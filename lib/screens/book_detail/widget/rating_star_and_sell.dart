import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/models/book_detail_model/book_detail_model.dart';
import 'package:mocktest/widgets/text_size_14.dart';

class RatingStarAndSell extends StatelessWidget {
  const RatingStarAndSell({super.key});

  // bool halfStar = (avgStar - star) > 0 ? true : false;

//  const RatingStar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        double? avgStar = 0;
        int star = avgStar.truncate();
        bool? halfStar; 
        BookDetail? bookDetail;
        if (state.status == BookStatus.success) {
          avgStar = state.bookDetail!.avgRate;
          star = avgStar!.truncate();
          halfStar = (avgStar - star) > 0 ? true : false;
          bookDetail = state.bookDetail;
        }

        if (bookDetail == null) {
          return const Text("Đang tải");
        }

        return Row(
          children: [
            for (int i = 0; i < star; i++)
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: SvgPicture.asset(SVGFile.ic_starYellow),
              ),
            halfStar!
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
                      for (int i = 0; i < 5 - star ; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: SvgPicture.asset(SVGFile.ic_star),
                        )
                    ],
                  ),
            const SizedBox(
              width: 6,
            ),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  AvgStar(avgStar.toString(), ChooseColor.colorBlack,
                      FontWeight.w600),
                  const SizedBox(
                    width: 6,
                  ),
                  Text('(${bookDetail.totalReview} đánh giá)',
                      style:
                          const TextStyle(fontSize: 12, fontWeight: FontWeight.w400))
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Container(
              width: 1,
              height: 16,
              color: ChooseColor.colorButton,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Đã bán: ${bookDetail.totalSold}',
              style: const TextStyle(fontSize: 13),
            )
          ],
        );
      },
    );
  }
}

Widget AvgStar(String text, Color color, FontWeight fontWeight) {
  return TextSize14(
    text: text,
    color: color,
    fontWeight: fontWeight,
  );
}
