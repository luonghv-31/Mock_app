import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktest/bloc/audio_book_bloc/bloc/audio_book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/screens/audio_book/widget/show_modal_bottom_list_audio.dart';
import 'package:mocktest/screens/audio_book/widget/show_modal_bottom_speed.dart';
import 'package:mocktest/widgets/show_dialog.dart';

class WidgetPlayer extends StatelessWidget {
  const WidgetPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBookBloc, AudioBookState>(
      builder: (context, state) {
        return Column(
          children: [
            ProgressBar(
              progress: state.processingState == ProcessingState.completed
                  ? Duration.zero
                  : state.position,
              //buffered: state.buffered,
              total: state.duration,
              baseBarColor: ChooseColor.colorBackgroundProgressBar,
              bufferedBarColor:
                  ChooseColor.colorButtonIsChoose.withOpacity(0.3),
              progressBarColor: ChooseColor.colorButtonIsChoose,
              thumbColor: ChooseColor.colorButtonIsChoose,
              thumbGlowColor: Colors.transparent,
              //  thumbGlowRadius: 5.0,
              timeLabelTextStyle: TextStyleAPP.textStyle14
                  .copyWith(color: ChooseColor.colorBlack),
              barHeight: 6,
              thumbRadius: 6,
              timeLabelLocation: TimeLabelLocation.sides,
              timeLabelPadding: 4,
              onSeek: (Duration duration) {
                BlocProvider.of<AudioBookBloc>(context)
                    .add(Seek(seek: duration));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 16,
                bottom: 12,
              ),
              child: Divider(
                color: ChooseColor.colorBackgroundBook,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<AudioBookBloc>(context)
                          .add(BackWard10s());
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: SvgPicture.asset(SVGFile.ic_backward),
                  ),
                  InkWell(
                    onTap: () {
                      
                     state.currentAudio != 0 ? BlocProvider.of<AudioBookBloc>(context).add(Pre()) : '';
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: SvgPicture.asset(SVGFile.ic_pre),
                  ),
                  state.isPlaying
                      ? InkWell(
                          onTap: () {
                            BlocProvider.of<AudioBookBloc>(context)
                                .add(PauseAudio());
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: SvgPicture.asset(
                            SVGFile.ic_pause,
                            width: 64,
                            height: 64,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            BlocProvider.of<AudioBookBloc>(context)
                                .add(PlayAudio());
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: SvgPicture.asset(
                            SVGFile.ic_play,
                            width: 64,
                            height: 64,
                          ),
                        ),
                  InkWell(
                    onTap: () {
                      state
                                  .audioBookModel!
                                  .bookContentDTO![state.currentAudio + 1]
                                  .type ==
                              0
                          ? BlocProvider.of<AudioBookBloc>(context).add(Next())
                          : showDialog(
                              context: context,
                              builder: (BuildContext context) {
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
                  InkWell(
                    onTap: () {
                      BlocProvider.of<AudioBookBloc>(context).add(ForWard10s());
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: SvgPicture.asset(SVGFile.ic_forward),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 12,
                bottom: 12,
              ),
              child: Divider(
                color: ChooseColor.colorBackgroundBook,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Text(
                          '${state.speed % 1 == 0 ? state.speed.toInt() : state.speed}x'),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          isDismissible: true,
                          builder: (context) => BlocProvider.value(
                            value: context.read<AudioBookBloc>(),
                            child: const ShowModalBottomSpeed(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 46,
                    ),
                    state.stateLoop == 'LoopMode.off'
                        ? InkWell(
                            onTap: () {
                              
                              BlocProvider.of<AudioBookBloc>(context)
                                  .add(LoopModee());
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: SvgPicture.asset(SVGFile.ic_no_repeat),
                          )
                        : state.stateLoop == 'LoopMode.one'
                            ? InkWell(
                                onTap: () {
                                  
                                  BlocProvider.of<AudioBookBloc>(context)
                                      .add(LoopModee());
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: SvgPicture.asset(SVGFile.ic_repeat_one),
                              )
                            : InkWell(
                                onTap: () {
                                  
                                  BlocProvider.of<AudioBookBloc>(context)
                                      .add(LoopModee());
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: SvgPicture.asset(SVGFile.ic_repeat_all),
                              ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      isDismissible: true,
                      builder: (context) => BlocProvider.value(
                        value: context.read<AudioBookBloc>(),
                        child: const showModalBottomListAudio(),
                      ),
                    );
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: SvgPicture.asset(SVGFile.ic_list_audio),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
