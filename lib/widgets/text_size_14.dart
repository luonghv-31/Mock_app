import 'package:flutter/cupertino.dart';

class TextSize14 extends StatelessWidget {
final  String text;
 final Color color;
 final FontWeight fontWeight;
  const TextSize14({super.key, required this.text, required this.color, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text( text,style: TextStyle(color: color, fontSize: 16,fontWeight:fontWeight )
      
    );
  }
}