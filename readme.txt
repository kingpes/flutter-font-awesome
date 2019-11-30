About
The Font Awesome Icon pack available as Flutter Icons. Provides 1500 additional icons to use in your apps.

Installing
font_awesome_flutter: ^8.5.0

Import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Usage
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return new IconButton(
      icon: new Icon(FontAwesomeIcons.gamepad), 
      onPressed: () { print("Pressed"); }
     );
  }
}