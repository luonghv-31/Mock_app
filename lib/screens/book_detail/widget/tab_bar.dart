import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/constants/url.dart';
import 'package:mocktest/models/book_detail_model/book_detail_model.dart';
import 'package:mocktest/models/book_models/book_total_review.dart';
import 'package:mocktest/screens/book_detail/widget/show_all_rating.dart';
import 'dart:ui' as ui;

class TabBarBook extends StatefulWidget {
  const TabBarBook({super.key});

  @override
  State<TabBarBook> createState() => _TabBarBookState();
}

class _TabBarBookState extends State<TabBarBook> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  bool isExpanded = false;
  bool isExpandedSeller = false;

  int getMaxLineText(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyleAPP.textStyle14.copyWith(
            color: ChooseColor.colorTextNearStar, fontWeight: FontWeight.w400),
      ),
      maxLines: null,
      textDirection: ui.TextDirection.ltr,
    )..layout(maxWidth: double.infinity - 32);
    return textPainter.computeLineMetrics().length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      BookDetail? bookDetail;
      List<Widget> listTab = [];
      BookTotalReview? bookTotalReview;
      if (state.status == BookStatus.success) {
        bookDetail = state.bookDetail;
        bookTotalReview = state.bookTotalReview;

        listTab = [
          introBook(bookDetail!.description.toString()),
          propertyBook(
              bookDetail.issuer.toString(),
              bookDetail.publicationTime.toString(),
              bookDetail.dimension.toString(),
              bookDetail.translator.toString(),
              bookDetail.pageNumber.toString(),
              bookDetail.coverType.toString(),
              bookDetail.coverType == 0 ? true : false),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: infoSeller(
              bookDetail.sellerAvatar.toString(),
              bookDetail.sellerFullname.toString(),
              bookDetail.sellerIntro.toString(),
            ),
          ),
          bookTotalReview!.totalReview != null
              ? const ShowAllRating()
              : Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
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
                        height: 6,
                      ),
                      SvgPicture.asset(SVGFile.ic_no_rating),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Chưa có đánh giá và bình chọn',
                        style: TextStyle(
                            color: ChooseColor.colorTextNearStar,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 4,
                      )
                    ],
                  ),
                ),
        ];
      }
      if (bookDetail == null) {
        return const Text("Loading");
      }
      return DefaultTabController(
          length: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabBar(
                  //  labelColor: ChooseColor.colorButtonIsChoose,

                  indicatorColor: ChooseColor.colorButtonIsChoose,
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  labelPadding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  tabAlignment: TabAlignment.start,
                  controller: _tabController,
                  isScrollable: true,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  dividerColor: ChooseColor.colorBorder,
                  labelStyle: TextStyleAPP.textStyle14
                      .copyWith(color: ChooseColor.colorButtonIsChoose),
                  unselectedLabelStyle: TextStyleAPP.textStyle14
                      .copyWith(color: ChooseColor.colorTextNearStar),
                  tabs: const [
                    Tab(child: Text("Giới thiệu sách")),
                    Tab(child: Text("Thông tin chi tiết")),
                    Tab(child: Text("Người bán")),
                    Tab(child: Text("Đánh giá")),
                  ]),

              AnimatedSwitcher(
                duration: const Duration(seconds: 0),
                child: [...listTab][_tabController.index],
              )

              //
            ],
          ));
    });
  }

  Widget introBook(String descriptionBook) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 0, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            descriptionBook,
            style: TextStyleAPP.textStyle14.copyWith(
                color: ChooseColor.colorTextNearStar,
                fontWeight: FontWeight.w400),
            maxLines: isExpanded ? null : 5,
            overflow: TextOverflow.fade,
          ),
          isExpanded
              ? InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      isExpanded = false;
                    });
                  },
                  child: Row(
                    children: [
                      Text("Thu gọn ",
                          style: TextStyleAPP.textStyle14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ChooseColor.colorButtonIsChoose)),
                      Transform.rotate(
                        angle: 3.1,
                        child: SvgPicture.asset(SVGFile.ic_arrow_down),
                      )
                    ],
                  ))
              : getMaxLineText(descriptionBook) > 5
                  ? InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          isExpanded = true;
                        });
                      },
                      child: Row(
                        children: [
                          Text("Xem thêm ",
                              style: TextStyleAPP.textStyle14.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: ChooseColor.colorButtonIsChoose)),
                          SvgPicture.asset(SVGFile.ic_arrow_down)
                        ],
                      ))
                  : const SizedBox()
        ],
      ),
    );
  }

  Widget infoSeller(String url, String sellerName, String intro) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin người bán',
          style: TextStyleAPP.textStyle16,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: ClipOval(
                child: Image.network(
                  URL.urlIMG + url,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/avatar.jpg'),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: Text(
              sellerName,
              style: TextStyleAPP.textStyle14
                  .copyWith(fontWeight: FontWeight.w600),
            )),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              splashColor: ChooseColor.colorButtonIsChoose.withOpacity(0.2),
              highlightColor: ChooseColor.colorButtonIsChoose.withOpacity(0.1),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: ChooseColor.colorButtonIsChoose, width: 1),
                ),
                child: const Text(
                  'Xem chi tiết',
                  style: TextStyle(color: ChooseColor.colorButtonIsChoose),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                intro,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyleAPP.textStyle14.copyWith(
                    color: ChooseColor.colorBlack, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget propertyBook(String company, String date, String size, String translator,
    String totalPage, String typeCover, bool isShowCover) {
  String formatDate(String date) {
    var inputDateFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputDateFormat.parse(date);
    var outputDateFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputDateFormat.format(inputDate);
    return outputDate;
  }

  print(company);
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Row(
      children: [
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            company == 'null' || company == ''
                ? const SizedBox(
                    height: 16,
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      'Công ty phát hành:',
                      style: TextStyleAPP.textStyle14
                          .copyWith(color: ChooseColor.colorProperties),
                    ),
                  ),
            Text("Ngày xuất bản:",
                style: TextStyleAPP.textStyle14
                    .copyWith(color: ChooseColor.colorProperties)),
            size == 'null' || size == ''
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(
                        top: 12,
                        bottom:
                            translator == 'null' || translator == '' ? 0 : 12),
                    child: Text("Kích thước:",
                        style: TextStyleAPP.textStyle14
                            .copyWith(color: ChooseColor.colorProperties)),
                  ),
            translator == 'null' || translator == ''
                ? const SizedBox()
                : Text('Dịch giả:',
                    style: TextStyleAPP.textStyle14
                        .copyWith(color: ChooseColor.colorProperties)),
            totalPage == 'null' || totalPage == ''
                ? const SizedBox()
                : Padding(
                    padding:
                        EdgeInsets.only(top: 12, bottom: isShowCover ? 12 : 0),
                    child: Text("Số trang:",
                        style: TextStyleAPP.textStyle14
                            .copyWith(color: ChooseColor.colorProperties)),
                  ),
            isShowCover
                ? Text('Loại bìa:',
                    style: TextStyleAPP.textStyle14
                        .copyWith(color: ChooseColor.colorProperties))
                : const SizedBox()
          ],
        )),
        const SizedBox(
          width: 24,
        ),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            company == 'null' || company == ''
                ? const SizedBox(
                    height: 16,
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      company,
                      style: TextStyleAPP.textStyle14
                          .copyWith(color: ChooseColor.colorBlack),
                    ),
                  ),
            Text(formatDate(date),
                style: TextStyleAPP.textStyle14
                    .copyWith(color: ChooseColor.colorBlack)),
            size == 'null' || size == ''
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(
                        top: 12,
                        bottom:
                            translator == 'null' || translator == '' ? 0 : 12),
                    child: Text('$size cm',
                        style: TextStyleAPP.textStyle14
                            .copyWith(color: ChooseColor.colorBlack)),
                  ),
            translator == 'null' || translator == ''
                ? const SizedBox()
                : Text(translator,
                    style: TextStyleAPP.textStyle14
                        .copyWith(color: ChooseColor.colorBlack)),
            totalPage == 'null' || totalPage == ''
                ? const SizedBox()
                : Padding(
                    padding:
                        EdgeInsets.only(top: 12, bottom: isShowCover ? 12 : 0),
                    child: Text(totalPage,
                        style: TextStyleAPP.textStyle14
                            .copyWith(color: ChooseColor.colorBlack)),
                  ),
            isShowCover
                ? Text(typeCover.toString() == '1' ? 'Bìa cứng' : "Bìa mềm",
                    style: TextStyleAPP.textStyle14
                        .copyWith(color: ChooseColor.colorBlack))
                : const SizedBox()
          ],
        ))
      ],
    ),
  );
}
