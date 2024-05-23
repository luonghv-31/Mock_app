import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/audio_book_bloc/bloc/audio_book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/widgets/show_dialog.dart';

class showModalBottomListAudio extends StatelessWidget {
  const showModalBottomListAudio({super.key});

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 300,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AudioBookBloc, AudioBookState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Danh sách phát (${state.audioBookModel!.bookContentDTO!.length})',
                      style: TextStyleAPP.textStyle16,
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.audioBookModel!.bookContentDTO!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (state.audioBookModel!.bookContentDTO![index]
                                      .type ==
                                  0 &&
                              state.currentAudio == index) {
                            state.isPlaying
                                ? ""
                                : BlocProvider.of<AudioBookBloc>(context)
                                    .add(PlayAudio());
                            Navigator.of(context).pop();
                          } else if (state.audioBookModel!
                                      .bookContentDTO![index].type ==
                                  0 &&
                              state.currentAudio != index) {
                            BlocProvider.of<AudioBookBloc>(context)
                                .add(SelectAudio(id: index));
                            BlocProvider.of<AudioBookBloc>(context)
                                .add(PlayAudio());
                            Navigator.of(context).pop();
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ShowDialog(
                                    textAndPrice:
                                        'MUA SÁCH NÓI ${state.audioBookModel!.booksDetailsDTO!.bookPrices}',
                                  );
                                });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 36,
                          decoration: BoxDecoration(
                              color: state.currentAudio ==
                                      state
                                          .audioBookModel!
                                          .bookContentDTO![index]
                                          .bookContentOrder
                                  ? ChooseColor.colorBackgroundSelect
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        index == 0 ? '   ' : '$index.',
                                        style: TextStyleAPP.textStyle14
                                            .copyWith(
                                                color: state.currentAudio ==
                                                        index
                                                    ? ChooseColor.colorBlack
                                                    : ChooseColor
                                                        .colorNamePartAudio),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        (state
                                                        .audioBookModel!
                                                        .bookContentDTO![index]
                                                        .bookContentName ==
                                                    '' &&
                                                index == 0)
                                            ? 'Nội dung nghe thử'
                                            : state
                                                        .audioBookModel!
                                                        .bookContentDTO![index]
                                                        .bookContentName ==
                                                    ''
                                                ? 'N/A'
                                                : state
                                                    .audioBookModel!
                                                    .bookContentDTO![index]
                                                    .bookContentName
                                                    .toString(),
                                        style: TextStyleAPP.textStyle14
                                            .copyWith(
                                                color: state.currentAudio ==
                                                        index
                                                    ? ChooseColor.colorBlack
                                                    : ChooseColor
                                                        .colorNamePartAudio),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '(${formatDuration(state.audioBookModel!.bookContentDTO![index].value!.toInt())})',
                                        style: TextStyleAPP.textStyle14
                                            .copyWith(
                                                color:
                                                    state.currentAudio == index
                                                        ? ChooseColor.colorBlack
                                                        : ChooseColor
                                                            .colorTextNearStar,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      state
                                                  .audioBookModel!
                                                  .bookContentDTO![index]
                                                  .type ==
                                              1
                                          ? (const SizedBox(
                                              width: 8,
                                            ))
                                          : const SizedBox(
                                              width: 26,
                                            )
                                    ],
                                  )),
                                  Row(
                                    children: [
                                      state
                                                  .audioBookModel!
                                                  .bookContentDTO![index]
                                                  .type ==
                                              1
                                          ? SvgPicture.asset(SVGFile.ic_lock)
                                          : const SizedBox(),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      state.currentAudio == index  && state.isPlaying
                                          ?  (SvgPicture.asset(
                                              SVGFile.ic_song_is_playing))
                                          : SvgPicture.asset(
                                              SVGFile.ic_play_small),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
