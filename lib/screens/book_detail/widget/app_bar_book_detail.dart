import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/text_style_app.dart';

class AppBarBookDetail extends StatelessWidget {
  const AppBarBookDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      title:  Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
           highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).maybePop();
            },
            child: SvgPicture.asset(SVGFile.ic_arrow_left,width: 20 ,height: 20,)),
        const  SizedBox(
            width: 16,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "CHI TIẾT SÁCH",style: TextStyleAPP.textStyle16,
              )),
        ],
      ),
     
    );
  }
}
