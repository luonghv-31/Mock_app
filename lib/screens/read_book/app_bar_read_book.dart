import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/read_book_bloc/bloc/read_book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/models/book_models/ebook_model.dart';
import 'package:mocktest/widgets/show_dialog.dart';

class AppBarReadBook extends StatelessWidget {
  const AppBarReadBook({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadBookBloc, ReadBookState>(
      builder: (context, state) {
        EbookModel? ebookModel = state.eBookModel;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_sharp)),
                Expanded(
                  child: Text(
                    state.eBookModel!.booksDetailsDTO!.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: ChooseColor.colorBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height / 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, right: 16, left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Danh sách',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(Icons.close))
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 12.0, bottom: 16),
                                    child: Text(
                                      'Mục lục',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: ChooseColor.colorAuthor),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            ebookModel!.bookContentDTO!.length,
                                        itemBuilder: ((context, index) {
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (state
                                                          .eBookModel!
                                                          .bookContentDTO![
                                                              index]
                                                          .type ==
                                                      0) {
                                                    BlocProvider.of<
                                                                ReadBookBloc>(
                                                            context)
                                                        .add(SelectChapter(
                                                            currentChapter:
                                                                index));
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return ShowDialog(
                                                            textAndPrice:
                                                                'MUA SÁCH ĐIỆN TỬ ${state.eBookModel!.booksDetailsDTO!.bookPrices}',
                                                          );
                                                        });
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: index ==
                                                              state
                                                                  .eBookModel!
                                                                  .bookContentDTO![
                                                                      state
                                                                          .currentChapter]
                                                                  .bookContentOrder!
                                                                  .toInt()
                                                          ? ChooseColor
                                                              .colorBackgroundSelect
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            top: 8,
                                                            bottom: 8),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                            width: 20,
                                                            child: index == 0
                                                                ? const Text('')
                                                                : Text(
                                                                    '$index.',
                                                                    style: TextStyleAPP
                                                                        .textStyle14
                                                                        .copyWith(
                                                                            color: index == state.eBookModel!.bookContentDTO![state.currentChapter].bookContentOrder!.toInt()
                                                                                ? ChooseColor.colorBlack
                                                                                : ChooseColor.colorNamePartAudio),
                                                                  )),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                                (ebookModel
                                                        .bookContentDTO![index]
                                                        .bookContentName ==
                                                    '' &&
                                                index == 0)
                                            ? 'Nội dung đọc thử'
                                            : ebookModel
                                                        .bookContentDTO![index]
                                                        .bookContentName ==
                                                    ''
                                                ? 'N/A'
                                                : ebookModel
                                                    .bookContentDTO![index]
                                                    .bookContentName
                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyleAPP.textStyle14.copyWith(
                                                                    color: index ==
                                                                            state.eBookModel!.bookContentDTO![state.currentChapter].bookContentOrder!
                                                                                .toInt()
                                                                        ? ChooseColor
                                                                            .colorBlack
                                                                        : ChooseColor
                                                                            .colorNamePartAudio))),
                                                        ebookModel
                                                                    .bookContentDTO![
                                                                        index]
                                                                    .type ==
                                                                1
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 4,
                                                                        right:
                                                                            10.0),
                                                                child: SvgPicture
                                                                    .asset(SVGFile
                                                                        .ic_lock),
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              )
                                            ],
                                          );
                                        })),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    icon: SvgPicture.asset(SVGFile.ic_table_of_content))
              ],
            ),
          ],
        );
      },
    );
  }
}
