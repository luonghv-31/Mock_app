import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktest/bloc/audio_book_bloc/bloc/audio_book_bloc.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/common/animation_navi_page.dart';
import 'package:mocktest/constants/url.dart';
import 'package:mocktest/main.dart';
import 'package:mocktest/screens/audio_book/audio_book_screen.dart';
import 'package:mocktest/widgets/show_dialog.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioBookBloc, AudioBookState>(
      listenWhen: (previous, current) {
        return previous.popUpPurchase != current.popUpPurchase;
      },
      listener: (context, state) {
        if (state.popUpPurchase && state.isScreenPlay == false) {
          showDialog(
            context: popUpGlobalKey.currentContext!,
            builder: (BuildContext context) {
              return ShowDialog(
                textAndPrice:
                    'MUA SÁCH NÓI ${state.audioBookModel!.booksDetailsDTO!.bookPrices}',
              );
            },
          );
        }
      },
      child: BlocBuilder<AudioBookBloc, AudioBookState>(
        builder: (context, state) {
          return state.isHaveMiniPlay
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, -2),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 4),
                        blurRadius: 0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  height: 100,
                  child: Stack(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          BlocProvider.of<AudioBookBloc>(context)
                              .add(IsScreenPlay());
                          Navigator.of(context).push(
                              createRoute(screens: const AudioBookScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 24.0, bottom: 20, left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadiusDirectional.circular(6),
                                child: Image.network(
                                  URL.urlIMG +
                                      state.audioBookModel!.booksDetailsDTO!
                                          .avatar!
                                          .split(',')
                                          .first,
                                  height: 52,
                                  width: 52,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const SizedBox(
                                          child: CircularProgressIndicator(
                                    color: ChooseColor.colorButtonIsChoose,
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Nội dung nghe thử',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: ChooseColor.colorBlack),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      height: 24,
                                      decoration: BoxDecoration(
                                          color: ChooseColor
                                              .colorBgrProgressBarMiniPlay,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0,
                                            top: 4,
                                            right: 12,
                                            bottom: 4),
                                        child: ProgressBar(
                                          progress: state.processingState ==
                                                  ProcessingState.completed
                                              ? Duration.zero
                                              : state.position,
                                          // buffered: state.buffered,
                                          total: state.duration,
                                          baseBarColor: ChooseColor
                                              .colorBackgroundProgressBar,
                                          bufferedBarColor: ChooseColor
                                              .colorButtonIsChoose
                                              .withOpacity(0.3),
                                          progressBarColor:
                                              ChooseColor.colorButtonIsChoose,
                                          thumbColor:
                                              ChooseColor.colorButtonIsChoose,
                                          thumbGlowColor: Colors.transparent,
                                          //  thumbGlowRadius: 5.0,
                                          timeLabelTextStyle:
                                              TextStyleAPP.textStyle14.copyWith(
                                                  color:
                                                      ChooseColor.colorBlack),
                                          barHeight: 6,
                                          thumbRadius: 6,
                                          timeLabelLocation:
                                              TimeLabelLocation.sides,
                                          timeLabelPadding: 4,
                                          onSeek: (Duration duration) {
                                            BlocProvider.of<AudioBookBloc>(
                                                    context)
                                                .add(Seek(seek: duration));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<AudioBookBloc>(context)
                                            .add(Pre());
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: SvgPicture.asset(SVGFile.ic_pre),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    state.isPlaying
                                        ? InkWell(
                                            onTap: () {
                                              BlocProvider.of<AudioBookBloc>(
                                                      context)
                                                  .add(PauseAudio());
                                            },
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: SvgPicture.asset(
                                              SVGFile.ic_pause,
                                              width: 32,
                                              height: 32,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              BlocProvider.of<AudioBookBloc>(
                                                      context)
                                                  .add(PlayAudio());
                                            },
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: SvgPicture.asset(
                                              SVGFile.ic_play,
                                              width: 32,
                                              height: 32,
                                            ),
                                          ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        state
                                                    .audioBookModel!
                                                    .bookContentDTO![
                                                        state.currentAudio + 1]
                                                    .type ==
                                                0
                                            ? BlocProvider.of<AudioBookBloc>(
                                                    context)
                                                .add(Next())
                                            : showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return ShowDialog(
                                                    textAndPrice:
                                                        'MUA SÁCH NÓI ${state.audioBookModel!.booksDetailsDTO!.bookPrices}',
                                                  );
                                                });
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: SvgPicture.asset(SVGFile.ic_next),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 8,
                          right: 16,
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<AudioBookBloc>(context)
                                  .add(StopAudio());
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: const Icon(Icons.close),
                          ))
                    ],
                  ))
              : BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 84,
                      child: Padding(
                        padding: EdgeInsetsDirectional.zero,
                        child: Column(
                          children: [
                            const Divider(
                              height: 0,
                              color: ChooseColor.colorButton,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: InkWell(
                                      child: SvgPicture.asset(SVGFile.ic_chat),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 12),
                                    child: InkWell(
                                      child: SvgPicture.asset(
                                          SVGFile.ic_add_to_cart),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 44,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          color:
                                              ChooseColor.colorButtonIsChoose,
                                          child: InkWell(
                                            onTap: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 12,
                                                  top: 12,
                                                  right: 12,
                                                  bottom: 12),
                                              child: Center(
                                                child: Text(
                                                  'Mua Hàng',
                                                  style: TextStyle(
                                                      color: ChooseColor
                                                          .colorButtonBuy,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: InkWell(
                                      child: SvgPicture.asset(SVGFile.ic_heart),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
