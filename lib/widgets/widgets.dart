import 'package:flutter/material.dart';

class Widgets {

  static void showPopUpMenuAtTap(BuildContext context, TapDownDetails details, List<PopupMenuItem<dynamic>> items) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: items,
      elevation: 8.0,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
    );
  }

  static alertSnackbar(BuildContext context, String content){
    final snackBar = SnackBar(content: Text(content));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
  
  static alertDialog(BuildContext context, String urlImg, String title){   
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  child: Image.network(urlImg)
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () { 
                Navigator.pop(context);
              } 
            )
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        );
      },
      barrierDismissible: false   
    ); 
  }


}