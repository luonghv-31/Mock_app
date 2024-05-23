import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/constants/url.dart';
import 'package:mocktest/models/book_detail_model/book_detail_model.dart';
import 'package:mocktest/models/book_models/more_book_model.dart';
import 'package:mocktest/screens/book_detail/book_detail_screen.dart';

class MoreBook extends StatelessWidget {
  const MoreBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Các sách khác của",
                    style: TextStyleAPP.textStyle16,
                  ),
                  BlocBuilder<BookBloc, BookState>(builder: (context, state) {
                    BookDetail? bookDetail;
                    if (state.status == BookStatus.success) {
                      bookDetail = state.bookDetail;
                    }
                    if (bookDetail == null) {
                      return const Text("");
                    }

                    return SizedBox(
                      width: 270,
                      child: Text(
                        bookDetail.sellerFullname!,
                        style: TextStyleAPP.textStyle16
                            .copyWith(color: ChooseColor.colorAuthor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  })
                ],
              ),
              Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: ChooseColor.colorBackgroundProgressBar,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    child: SvgPicture.asset(
                      SVGFile.ic_arrow_right,
                      width: 14,
                      height: 14,
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const RelateBook()
      ],
    );
  }
}

class RelateBook extends StatefulWidget {
  const RelateBook({super.key});

  @override
  State<RelateBook> createState() => _RelateBookState();
}

class _RelateBookState extends State<RelateBook> {
  String getTypeOfBook(String typeBook) {
    bool isHardBook = typeBook.contains('0');

    bool isEBook = typeBook.contains('1');
    bool isAudioBook = typeBook.contains('2');

    String aaa =
        '${isHardBook ? ', Sách in' : ''}${isEBook ? ', Sách điện tử' : ''}${isAudioBook ? ', Sách nghe' : ''}';

    return aaa.substring(2);
  }

  bool isHot = false;
  bool isBestSeller = false;
  int _currentIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        List<BookRelateModel>? bookRelateModel;

        if (state.status == BookStatus.success) {
          bookRelateModel = state.bookRelateModel;
          print(bookRelateModel.length);
        }

        return Column(
          children: [
            SizedBox(
              height: 340,
              child: Stack(children: [
                PageView.builder(
                    itemCount: (bookRelateModel!.length / 2).ceil(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                        print(index);
                      });
                    },
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(child: pageMoreBook(index * 2)),
                          index * 2 + 1 == bookRelateModel!.length &&
                                  bookRelateModel.length % 2 != 0
                              ? const SizedBox()
                              : Expanded(child: pageMoreBook(index * 2 + 1)),
                        ],
                      );
                    }),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  (bookRelateModel.length / 2).ceil(),
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? Colors.amber
                                : ChooseColor.colorDotIdicatorBar,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )),
            ),
            const SizedBox(
              height: 36,
            ),
          ],
        );
      },
    );
  }

  Widget pageMoreBook(int index) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      List<BookRelateModel>? bookRelateModel;

      if (state.status == BookStatus.success) {
        bookRelateModel = state.bookRelateModel;
      }
      if (bookRelateModel == null) {
        return const Text('Đang tải');
      }
      return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          // ..add(CallAPI(idBook: '96'))
          //  BlocProvider.of<BookBloc>(context).add(CallAPI(idBook: bookRelateModel![index].id.toString()));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetailScreen(
                        idBook: bookRelateModel![index].id.toString(),
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 200,
                    decoration: BoxDecoration(
                      color: ChooseColor.colorBackgroundBook,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Image.network(
                    (URL.urlIMG + bookRelateModel[index].avatar.toString())
                        .split(',')[0],
                    fit: BoxFit.cover,
                    width: 120,
                    height: 160,
                    errorBuilder: (context, error, stackTrace) =>
                        SvgPicture.asset(
                      SVGFile.img_book_error,
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 12,
                      child: Row(
                        children: [
                          bookRelateModel[index].haveHot!
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 26,
                                  decoration: BoxDecoration(
                                    color: ChooseColor.colorBannerHot,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    "Hot",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                          bookRelateModel[index].haveHot!
                              ? const SizedBox(
                                  width: 10,
                                )
                              : const SizedBox(),
                          bookRelateModel[index].haveBestSeller!
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: ChooseColor.colorBestSeller,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    "Best Seller",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "${bookRelateModel[index].topicBookName}",
                style: TextStyleAPP.textStyle14
                    .copyWith(color: ChooseColor.colorTypeBook),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                children: [
                  bookRelateModel[index].avgRate!.toInt() != 0
                      ? SvgPicture.asset(SVGFile.ic_starYellow)
                      : const SizedBox(),
                  bookRelateModel[index].avgRate!.toInt() != 0
                      ? const SizedBox(
                          width: 4,
                        )
                      : const SizedBox(),
                  bookRelateModel[index].avgRate!.toInt() != 0
                      ? Text(
                          '${bookRelateModel[index].avgRate}',
                          style: TextStyleAPP.textStyle14.copyWith(
                              color: const Color.fromRGBO(0, 0, 0, 1)),
                        )
                      : const SizedBox(),
                  bookRelateModel[index].avgRate!.toInt() != 0
                      ? const SizedBox(
                          width: 4,
                        )
                      : const SizedBox(),
                  Text(
                    'Đã bán: ${bookRelateModel[index].totalSold}',
                    style: TextStyleAPP.textStyle14
                        .copyWith(color: ChooseColor.colorTypeBook),
                  )
                ],
              ),
              Text(
                "${bookRelateModel[index].name}",
                style: TextStyleAPP.textStyle14.copyWith(
                    color: ChooseColor.colorBlack,
                    fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  SvgPicture.asset(SVGFile.ic_group),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      '${bookRelateModel[index].author}',
                      style: TextStyleAPP.textStyle14
                          .copyWith(color: ChooseColor.colorProperties),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(SVGFile.ic_book_small),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      getTypeOfBook(
                          bookRelateModel[index].bookTypes.toString()),
                      style: TextStyleAPP.textStyle14
                          .copyWith(color: ChooseColor.colorProperties),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              Text(
                '${bookRelateModel[index].minPrice}₭',
                style: TextStyleAPP.textStyle14.copyWith(
                    color: ChooseColor.colorBlack, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    });
  }
}
