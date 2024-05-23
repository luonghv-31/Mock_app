import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktest/bloc/audio_book_bloc/bloc/audio_book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/text_style_app.dart';
import 'package:mocktest/constants/url.dart';
import 'package:mocktest/main.dart';
import 'package:mocktest/screens/audio_book/widget/widget_player.dart';
import 'package:mocktest/widgets/show_dialog.dart';

class AudioBookScreen extends StatefulWidget {
  const AudioBookScreen({super.key});

  @override
  State<AudioBookScreen> createState() => _AudioBookScreenState();
}

class _AudioBookScreenState extends State<AudioBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AudioBookBloc, AudioBookState>(
        listenWhen: (previous, current) =>
            previous.popUpPurchase != current.popUpPurchase,
        listener: (context, state) {
          if (state.popUpPurchase) {
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
            if (state.status == AudioBookStatus.initial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == AudioBookStatus.failure) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              return SafeArea(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  BlocProvider.of<AudioBookBloc>(context)
                                      .add(IsScreenPlay());
                                },
                                icon: const Icon(Icons.keyboard_arrow_down)),
                            Text(
                              '${state.audioBookModel!.booksDetailsDTO!.name}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: ChooseColor.colorBlack),
                            ),
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<AudioBookBloc>(context)
                                      .add(StopAudio());
                                  BlocProvider.of<AudioBookBloc>(context)
                                      .add(IsScreenPlay());
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close)),
                          ],
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  URL.urlIMG +
                                      state.audioBookModel!.booksDetailsDTO!
                                          .avatar!
                                          .split(',')
                                          .first,
                                  height: 395,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            top: 16.0,
                                            bottom: 4,
                                          ),
                                          child: Text(
                                            '${state.audioBookModel!.bookContentDTO![0].bookContentName == '' ? 'Nội dung nghe thử' : state.audioBookModel!.bookContentDTO![0].bookContentName}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: ChooseColor.colorBlack,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 4,
                                          ),
                                          child: Row(
                                            children: [
                                              Text('Tác giả: ',
                                                  style: TextStyleAPP
                                                      .textStyle14
                                                      .copyWith(
                                                          color: ChooseColor
                                                              .colorNameSeller)),
                                              Text(
                                                state.audioBookModel!
                                                    .booksDetailsDTO!.author
                                                    .toString(),
                                                style: TextStyleAPP.textStyle14,
                                              ),
                                            ],
                                          )),
                                      Row(
                                        children: [
                                          Text(
                                            'Tác phẩm: ',
                                            style: TextStyleAPP.textStyle14
                                                .copyWith(
                                                    color: ChooseColor
                                                        .colorNameSeller),
                                          ),
                                          Text(
                                            state.audioBookModel!
                                                .booksDetailsDTO!.name
                                                .toString(),
                                            style: TextStyleAPP.textStyle14
                                                .copyWith(
                                                    color:
                                                        ChooseColor.colorBlack),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 24,
                                          bottom: 16,
                                        ),
                                        child: Divider(
                                          color:
                                              ChooseColor.colorBackgroundBook,
                                        ),
                                      ),
                                      const WidgetPlayer()
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
