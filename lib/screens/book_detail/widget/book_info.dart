import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/bloc/read_book_bloc/bloc/read_book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/config.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/models/book_detail_model/book_detail_model.dart';
import 'package:mocktest/screens/book_detail/widget/button.dart';
import 'package:mocktest/screens/book_detail/widget/rating_star_and_sell.dart';
import 'package:mocktest/screens/read_book/read_book_screen.dart';
import 'package:mocktest/widgets/show_dialog.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      BookDetail? bookDetail;
      String? priceTypeBook;

      if (state.status == BookStatus.success) {
        bookDetail = state.bookDetail;
        priceTypeBook = state.priceTypeBook;
      }
      if (bookDetail == null) {
        return const Text("Đang tải");
      }
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    bookDetail.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ChooseColor.colorBlack),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  '$priceTypeBook ₭',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ChooseColor.colorButtonIsChoose),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const RatingStarAndSell(),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 104,
                  child: Text(
                    "Tác giả: ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                    child: Text(
                  bookDetail.author.toString(),
                  style: TextStyleAPP.textStyle14,
                ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 104,
                  child: Text(
                    "Nhà xuất bản: ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                    child: Text(
                  bookDetail.publisher.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                    width: 76,
                    child: Text(
                      "Số lượng",
                      style: TextStyleAPP.textStyle14.copyWith(
                          color: ChooseColor.colorTextButtonAndTextBold),
                    )),
                BlocBuilder<BookBloc, BookState>(builder: (context, state) {
                  TypeBook? typeBook;
                  BookDetail? bookDetail;
                  if (state.status == BookStatus.success) {
                    typeBook = state.selectBook;
                    bookDetail = state.bookDetail;
                  }

                  return bookDetail!.bookTypes!.contains('0')
                      ? typeBook == TypeBook.book
                          ? const IncreaseNumber()
                          : Container(
                              height: 32,
                              width: 40,
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: ChooseColor.colorBorder,
                                ),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: ChooseColor.colorBlack,
                                      fontSize: 14),
                                ),
                              ),
                            )
                      : Container(
                          height: 32,
                          width: 40,
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: ChooseColor.colorBorder,
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              '1',
                              style: TextStyle(
                                  color: ChooseColor.colorBlack, fontSize: 14),
                            ),
                          ),
                        );
                }),
              ],
            ),
            BlocBuilder<BookBloc, BookState>(builder: (context, state) {
              TypeBook? typeBook;
              BookDetail? bookDetail;

              if (state.status == BookStatus.success) {
                typeBook = state.selectBook;
                bookDetail = state.bookDetail;
              }

              return Row(
                children: [
                  bookDetail!.bookTypes!.contains('0')
                      ? typeBook == TypeBook.book
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 12),
                              child: ButtonBook(isChoose: true),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 12),
                              child: ButtonBook(isChoose: false),
                            )
                      : const SizedBox(),
                  bookDetail.bookTypes!.contains('1')
                      ? typeBook == TypeBook.ebook
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 12),
                              child: ButtonEbook(isChoose: true),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 12),
                              child: ButtonEbook(isChoose: false),
                            )
                      : const SizedBox(),
                  bookDetail.bookTypes!.contains('2')
                      ? typeBook == TypeBook.audiobook
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 12),
                              child: ButtonBookPlay(isChoose: true),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 12),
                              child: ButtonBookPlay(isChoose: false),
                            )
                      : const SizedBox(),
                ],
              );
            }),
            BlocBuilder<BookBloc, BookState>(builder: (context, state) {
              TypeBook? typeBook;
              BookDetail? bookDetail;
              // bool isChoose;
              if (state.status == BookStatus.success) {
                typeBook = state.selectBook;
                bookDetail = state.bookDetail;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bookDetail!.bookTypes!.contains('0')
                        ? typeBook == TypeBook.book
                            ? Expanded(
                                child: Row(
                                  children: [
                                    bookDetail.bookTypes!.contains('1')
                                        ? Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 16.0,
                                              ),
                                              child: ReadBook(
                                                // readBook: () {
                                                //   BlocProvider.of<ReadBookBloc>(
                                                //           context)
                                                //       .add(CallApiReadBook(
                                                //           idBook: bookDetail!.id
                                                //               .toString(),
                                                //        ));

                                                //   print('asdgfasdf');
                                                // },
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    bookDetail.bookTypes!.contains('2')
                                        ? const SizedBox(
                                            width: 8,
                                          )
                                        : const SizedBox(),
                                    bookDetail.bookTypes!.contains('2')
                                        ? const Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 16.0),
                                              child: ListenBook(),
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    bookDetail.bookTypes!.contains('1')
                        ? typeBook == TypeBook.ebook
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16.0,
                                  ),
                                  child: ReadBook(
                                   

                                  ),
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    bookDetail.bookTypes!.contains('2')
                        ? typeBook == TypeBook.audiobook
                            ? const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: ListenBook(),
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox()
                  ],
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}

class IncreaseNumber extends StatefulWidget {
  const IncreaseNumber({super.key});

  @override
  State<IncreaseNumber> createState() => _IncreaseNumberState();
}

int saveCount = 1;

class _IncreaseNumberState extends State<IncreaseNumber> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      if (saveCount != _counter) {
        _counter = saveCount;
      }
      _counter++;
      saveCount = _counter;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (saveCount != _counter) {
        _counter = saveCount;
      }
      _counter--;
      saveCount = _counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 96,
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: ChooseColor.colorBorder,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                saveCount == 0 ? {} : _decrementCounter();
              },
              child: Icon(
                Icons.remove,
                color: saveCount == 0
                    ? ChooseColor.colorBorder
                    : ChooseColor.colorIncreaseButton,
                size: 16,
              )),
          Text(
            '$saveCount',
            style: const TextStyle(color: ChooseColor.colorBlack, fontSize: 14),
          ),
          InkWell(
              onTap: () {
                _incrementCounter();
              },
              child: const Icon(
                Icons.add,
                color: ChooseColor.colorIncreaseButton,
                size: 16,
              )),
        ],
      ),
    );
  }
}
