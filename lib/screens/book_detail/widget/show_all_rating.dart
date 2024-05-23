import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';

import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
// import 'package:mocktest/constants/svg_file.dart';
// import 'package:mocktest/constants/url.dart';
import 'package:mocktest/models/book_models/book_all_rating.dart';
import 'package:mocktest/models/book_models/book_total_review.dart';
import 'package:mocktest/screens/book_detail/widget/build_list_review.dart';
import 'package:mocktest/screens/book_detail/widget/button.dart';
import 'package:mocktest/widgets/rating_star.dart';

class ShowAllRating extends StatefulWidget {
  const ShowAllRating({super.key});

  @override
  State<ShowAllRating> createState() => _ShowAllRatingState();
}

class _ShowAllRatingState extends State<ShowAllRating>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
    });
  }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> listTab = [];
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      List<BookAllRating> bookAllRating = [];
      BookTotalReview? bookTotalReview;
      double totalPoint;
      double? avgPoint;
      List<BookAllRating> listRate1 = [];
      List<BookAllRating> listRate2 = [];
      List<BookAllRating> listRate3 = [];
      List<BookAllRating> listRate4 = [];
      List<BookAllRating> listRate5 = [];

      if (state.status == BookStatus.success) {
        bookAllRating = state.bookAllRating;
        bookTotalReview = state.bookTotalReview;
      }

      if (bookTotalReview != null) {
        totalPoint = bookTotalReview.listReviewRate!.totalRate1! +
            (bookTotalReview.listReviewRate!.totalRate2! * 2) +
            (bookTotalReview.listReviewRate!.totalRate3! * 3) +
            (bookTotalReview.listReviewRate!.totalRate4! * 4) +
            (bookTotalReview.listReviewRate!.totalRate5! * 5);

        avgPoint = totalPoint / bookTotalReview.totalReview!;
      }

      if (bookAllRating != []) {
        for (var element in bookAllRating) {
          if (element.rate == 1) {
            listRate1.add(element);
          }
          if (element.rate == 2) {
            listRate2.add(element);
          }
          if (element.rate == 3) {
            listRate3.add(element);
          }
          if (element.rate == 4) {
            listRate4.add(element);
          }
          if (element.rate == 5) {
            listRate5.add(element);
          }
        }

        listTab = [
          listRate5.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listRate5.length,
                  itemBuilder: ((context, index) {
                    return BuildListReview(
                      isReply:
                          listRate5[index].contentSeller != null ? true : false,
                      avatarBuyer: listRate5[index].avatarBuyer.toString(),
                      imgAvatarSeller: listRate5[index].avatarSeller.toString(),
                      nameBuyer: listRate5[index].fullNameBuyer.toString(),
                      contentBuyer: listRate5[index].contentBuyer.toString(),
                      imgPathBuyer: listRate5[index].filePathBuyer != null
                          ? listRate5[index].filePathBuyer.toString()
                          : '[]',
                      contentSeller: listRate5[index].contentSeller.toString(),
                      imgPathSeller: listRate5[index].filePathSeller != null
                          ? listRate5[index].filePathSeller.toString()
                          : '[]',
                      createReviewAt: listRate5[index].createTime.toString(),
                      isDivider: index == listRate5.length - 1 ? false : true,
                    );
                  }))
              : noRating(),
          listRate4.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listRate4.length,
                  itemBuilder: ((context, index) {
                    return BuildListReview(
                      isReply:
                          listRate4[index].contentSeller != null ? true : false,
                      avatarBuyer: listRate4[index].avatarBuyer.toString(),
                      imgAvatarSeller: listRate4[index].avatarSeller.toString(),
                      nameBuyer: listRate4[index].fullNameBuyer.toString(),
                      contentBuyer: listRate4[index].contentBuyer.toString(),
                      imgPathBuyer: listRate4[index].filePathBuyer != null
                          ? listRate4[index].filePathBuyer.toString()
                          : '[]',
                      contentSeller: listRate4[index].contentSeller.toString(),
                      imgPathSeller: listRate4[index].filePathSeller != null
                          ? listRate4[index].filePathSeller.toString()
                          : '[]',
                      createReviewAt: listRate4[index].createTime.toString(),
                      isDivider: index == listRate4.length - 1 ? false : true,
                    );
                  }))
              : noRating(),
          listRate3.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listRate3.length,
                  itemBuilder: ((context, index) {
                    return BuildListReview(
                      isReply:
                          listRate3[index].contentSeller != null ? true : false,
                      avatarBuyer: listRate3[index].avatarBuyer.toString(),
                      imgAvatarSeller: listRate3[index].avatarSeller.toString(),
                      nameBuyer: listRate3[index].fullNameBuyer.toString(),
                      contentBuyer: listRate3[index].contentBuyer.toString(),
                      imgPathBuyer: listRate3[index].filePathBuyer != null
                          ? listRate3[index].filePathBuyer.toString()
                          : '[]',
                      contentSeller: listRate3[index].contentSeller.toString(),
                      imgPathSeller: listRate3[index].filePathSeller != null
                          ? listRate3[index].filePathSeller.toString()
                          : '[]',
                      createReviewAt: listRate3[index].createTime.toString(),
                      isDivider: index == listRate3.length - 1 ? false : true,
                    );
                  }))
              : noRating(),
          listRate2.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listRate2.length,
                  itemBuilder: ((context, index) {
                    return BuildListReview(
                      isReply:
                          listRate2[index].contentSeller != null ? true : false,
                      avatarBuyer: listRate2[index].avatarBuyer.toString(),
                      imgAvatarSeller: listRate2[index].avatarSeller.toString(),
                      nameBuyer: listRate2[index].fullNameBuyer.toString(),
                      contentBuyer: listRate2[index].contentBuyer.toString(),
                      imgPathBuyer: listRate2[index].filePathBuyer != null
                          ? listRate2[index].filePathBuyer.toString()
                          : '[]',
                      contentSeller: listRate2[index].contentSeller.toString(),
                      imgPathSeller: listRate2[index].filePathSeller != null
                          ? listRate2[index].filePathSeller.toString()
                          : '[]',
                      createReviewAt: listRate2[index].createTime.toString(),
                      isDivider: index == listRate2.length - 1 ? false : true,
                    );
                  }))
              : noRating(),
          listRate1.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listRate1.length,
                  itemBuilder: ((context, index) {
                    return BuildListReview(
                      isReply:
                          listRate1[index].contentSeller != null ? true : false,
                      avatarBuyer: listRate1[index].avatarBuyer.toString(),
                      imgAvatarSeller: listRate1[index].avatarSeller.toString(),
                      nameBuyer: listRate1[index].fullNameBuyer.toString(),
                      contentBuyer: listRate1[index].contentBuyer.toString(),
                      imgPathBuyer: listRate1[index].filePathBuyer != null
                          ? listRate1[index].filePathBuyer.toString()
                          : '[]',
                      contentSeller: listRate1[index].contentSeller.toString(),
                      imgPathSeller: listRate1[index].filePathSeller != null
                          ? listRate1[index].filePathSeller.toString()
                          : '[]',
                      createReviewAt: listRate1[index].createTime.toString(),
                      isDivider: index == listRate1.length - 1 ? false : true,
                    );
                  }))
              : noRating(),
        ];
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, left: 16, right: 16, bottom: 16),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Đánh giá và bình chọn",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ChooseColor.colorBlack),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            avgPoint!.toStringAsFixed(1),
                            style: const TextStyle(
                                color: ChooseColor.colorAvgRating,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          RatingStar(
                              avgStar: avgPoint,
                              star: avgPoint.truncate(),
                              halfStar: (avgPoint - avgPoint.truncate()) > 0
                                  ? true
                                  : false),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Based on ${bookTotalReview!.totalReview!} review',
                            style: const TextStyle(
                                fontSize: 10,
                                color: ChooseColor.colorTotalRating,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          progressBarReview(
                              1,
                              bookTotalReview.listReviewRate!.totalRate1! /
                                  bookTotalReview.totalReview!.toDouble()),
                          progressBarReview(
                              2,
                              bookTotalReview.listReviewRate!.totalRate2! /
                                  bookTotalReview.totalReview!.toDouble()),
                          progressBarReview(
                              3,
                              bookTotalReview.listReviewRate!.totalRate3! /
                                  bookTotalReview.totalReview!.toDouble()),
                          progressBarReview(
                              4,
                              bookTotalReview.listReviewRate!.totalRate4! /
                                  bookTotalReview.totalReview!.toDouble()),
                          progressBarReview(
                              5,
                              bookTotalReview.listReviewRate!.totalRate5! /
                                  bookTotalReview.totalReview!.toDouble())
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          DefaultTabController(
              length: 5,
              child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TabBar(
                      indicatorColor: Colors.transparent,
                      padding: const EdgeInsets.only(left: 20),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelPadding: const EdgeInsets.only(left: 4, right: 8),
                      tabAlignment: TabAlignment.start,
                      controller: _tabController,
                      isScrollable: true,

                      // enableFeedback: false,
                      //   splashFactory: NoSplash.splashFactory,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(
                            child: ButtonStar(
                          star: 5,
                          totalStar: bookTotalReview.listReviewRate!.totalRate5,
                          colorBorder: tabIndex == 0
                              ? ChooseColor.colorButtonIsChoose
                              : ChooseColor.colorButton,
                          colorBackground: tabIndex == 0
                              ? ChooseColor.colorBackgroudIndicator
                              : Colors.transparent,
                        )),
                        Tab(
                            child: ButtonStar(
                                star: 4,
                                totalStar:
                                    bookTotalReview.listReviewRate!.totalRate4,
                                colorBorder: tabIndex == 1
                                    ? ChooseColor.colorButtonIsChoose
                                    : ChooseColor.colorButton,
                                colorBackground: tabIndex == 1
                                    ? ChooseColor.colorBackgroudIndicator
                                    : Colors.transparent)),
                        Tab(
                            child: ButtonStar(
                                star: 3,
                                totalStar:
                                    bookTotalReview.listReviewRate!.totalRate3,
                                colorBorder: tabIndex == 2
                                    ? ChooseColor.colorButtonIsChoose
                                    : ChooseColor.colorButton,
                                colorBackground: tabIndex == 2
                                    ? ChooseColor.colorBackgroudIndicator
                                    : Colors.transparent)),
                        Tab(
                            child: ButtonStar(
                                star: 2,
                                totalStar:
                                    bookTotalReview.listReviewRate!.totalRate2,
                                colorBorder: tabIndex == 3
                                    ? ChooseColor.colorButtonIsChoose
                                    : ChooseColor.colorButton,
                                colorBackground: tabIndex == 3
                                    ? ChooseColor.colorBackgroudIndicator
                                    : Colors.transparent)),
                        Tab(
                            child: ButtonStar(
                                star: 1,
                                totalStar:
                                    bookTotalReview.listReviewRate!.totalRate1,
                                colorBorder: tabIndex == 4
                                    ? ChooseColor.colorButtonIsChoose
                                    : ChooseColor.colorButton,
                                colorBackground: tabIndex == 4
                                    ? ChooseColor.colorBackgroudIndicator
                                    : Colors.transparent)),
                      ],
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(seconds: 0),
                      child: [...listTab][_tabController.index],
                    )
                  ])),
        ],
      );
    });
  }

  Widget progressBarReview(int number, double review) {
    return Column(
      children: [
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text(
              number.toString(),
              style: const TextStyle(
                  color: ChooseColor.colorTotalRating,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 83,
              child: LinearProgressIndicator(
                value: review,
                backgroundColor: ChooseColor.colorBackgroudIndicator,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    ChooseColor.colorButtonIsChoose),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget noRating() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: Column(
        children: [
          SvgPicture.asset(SVGFile.ic_no_rating),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Chưa có đánh giá nào',
            style: TextStyle(
                color: ChooseColor.colorTextNearStar,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}
