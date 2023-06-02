import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_sky_scrapper/models/color_model.dart';

// custom Text Widget
Widget appText(
    {required String text,
    FontWeight fw = FontWeight.normal,
    Color color = ColorModel.primaryColor,
    double size = 18,
    int maxLines = 0,
    bool overflow = false,
    bool alignCenter = false}) {
  return Text(
    text,
    textAlign: alignCenter == true ? TextAlign.center : null,
    maxLines: maxLines == 0 ? null : maxLines,
    overflow: overflow == true ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fw,
    ),
  );
}

// Custom ListTile for MainScreen
Widget customListTile({
  required String first,
  required String second,
  required IconData icon,
  required Color iconColor,
  String text = '',
}) {
  return ListTile(
    trailing: appText(size: 16, text: text, color: ColorModel.darkGreyColor),
    leading: Icon(icon, color: iconColor),
    title: RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: first,
            style:
                const TextStyle(color: ColorModel.darkGreyColor, fontSize: 16),
          ),
          TextSpan(
            text: second,
            style: const TextStyle(
                color: ColorModel.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

TextStyle titleTSW(
    {double fs = 18,
    FontWeight fw = FontWeight.w500,
    Color co = Colors.white}) {
  return TextStyle(fontSize: fs, fontWeight: fw, color: co);
}

TextStyle summaryTSW(
    {double fs = 16,
    FontWeight fw = FontWeight.w500,
    Color co = Colors.white}) {
  return TextStyle(fontSize: fs, fontWeight: fw, color: co);
}

TextStyle titleTSB(
    {double fs = 18,
    FontWeight fw = FontWeight.w500,
    Color co = Colors.black87}) {
  return TextStyle(fontSize: fs, fontWeight: fw, color: co);
}

TextStyle summaryTSB(
    {double fs = 16,
    FontWeight fw = FontWeight.w500,
    Color co = Colors.black87}) {
  return TextStyle(fontSize: fs, fontWeight: fw, color: co);
}

myToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
