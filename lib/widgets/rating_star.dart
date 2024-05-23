import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktest/constants/svg_file.dart';

class RatingStar extends StatelessWidget {
  double avgStar;
  int star ;
  bool halfStar;

  RatingStar({super.key, required this.avgStar, required this.star, required this.halfStar});

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        for (int i = 0; i < star; i++)
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: SvgPicture.asset(SVGFile.ic_starYellow),
          ),
        halfStar
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: SvgPicture.asset(SVGFile.ic_halfStar),
                  ),
                  for (int i = 0; i < 5 - star - 1; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: SvgPicture.asset(SVGFile.ic_star),
                    )
                ],
              )
            : Row(
                children: [
                  for (int i = 0; i < 5 - star; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: SvgPicture.asset(SVGFile.ic_star),
                    )
                ],
              ),
      ],
    );
  }
}
