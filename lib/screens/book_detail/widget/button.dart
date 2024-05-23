import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/audio_book_bloc/bloc/audio_book_bloc.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/bloc/read_book_bloc/bloc/read_book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/config.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/main.dart';
import 'package:mocktest/screens/read_book/read_book_screen.dart';
import 'package:mocktest/widgets/show_dialog.dart';

class ButtonQuantity extends StatelessWidget {
  const ButtonQuantity({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('fghdf');
  }
}

class ButtonBook extends StatelessWidget {
  bool isChoose;

  ButtonBook({super.key, required this.isChoose});

  @override
  Widget build(BuildContext context) {
    TypeBook typeBook = TypeBook.book;
    return SizedBox(
      height: 44,
      child: TextButton(
        onPressed: () {
          // ApiBookDetailProvider().getBookDetail();
          BlocProvider.of<BookBloc>(context).add(SelectTypeBook(typeBook));
        },
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(isChoose
                ? ChooseColor.colorButtonIsChoose
                : ChooseColor.colorBlack),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(
                        color: isChoose
                            ? ChooseColor.colorButtonIsChoose
                            : ChooseColor.colorButton))),
            splashFactory: NoSplash.splashFactory),
        child: Text(
          'SÁCH IN',
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isChoose
                  ? ChooseColor.colorButtonIsChoose
                  : ChooseColor.colorBlack),
        ),
      ),
    );
  }
}

class ButtonEbook extends StatelessWidget {
  bool isChoose;
  final TypeBook _typeBook = TypeBook.ebook;
  ButtonEbook({super.key, required this.isChoose});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextButton(
        onPressed: () {
          BlocProvider.of<BookBloc>(context).add(SelectTypeBook(_typeBook));
        },
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(isChoose
                ? ChooseColor.colorButtonIsChoose
                : ChooseColor.colorBlack),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(
                        color: isChoose
                            ? ChooseColor.colorButtonIsChoose
                            : ChooseColor.colorButton))),
            splashFactory: NoSplash.splashFactory),
        child: Text(
          'SÁCH ĐIỆN TỬ',
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isChoose
                  ? ChooseColor.colorButtonIsChoose
                  : ChooseColor.colorBlack),
        ),
      ),
    );
  }
}

class ButtonBookPlay extends StatelessWidget {
  bool isChoose;
  final TypeBook _typeBook = TypeBook.audiobook;
  ButtonBookPlay({super.key, required this.isChoose});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextButton(
        onPressed: () {
          BlocProvider.of<BookBloc>(context).add(SelectTypeBook(_typeBook));
        },
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(isChoose
                ? ChooseColor.colorButtonIsChoose
                : ChooseColor.colorBlack),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(
                        color: isChoose
                            ? ChooseColor.colorButtonIsChoose
                            : ChooseColor.colorButton))),
            splashFactory: NoSplash.splashFactory),
        child: Text(
          'SÁCH NÓI',
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isChoose
                  ? ChooseColor.colorButtonIsChoose
                  : ChooseColor.colorBlack),
        ),
      ),
    );
  }
}

class ReadBook extends StatelessWidget {
  const ReadBook({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: TextButton(
            onPressed: () {
              print('data');
              BlocProvider.of<ReadBookBloc>(context).add(CallApiReadBook(
                idBook: state.bookDetail!.id.toString(),
                handleUnlock: (){
                   showDialog(
          context: popUpGlobalKey.currentContext!,
          builder: (BuildContext context) {
            return ShowDialog(
              textAndPrice:
                  'MUA SÁCH ĐIỆN TỬ ${state.bookDetail!.ebook!.price}',
            );
          },
        );
                }, pushScreen: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReadBookScreen())),
              ));
            },
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(ChooseColor.colorAuthor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side:
                            const BorderSide(color: ChooseColor.colorAuthor)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(SVGFile.ic_readBook),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Đọc sách",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ListenBook extends StatelessWidget {
  const ListenBook({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: TextButton(
            onPressed: () {
              BlocProvider.of<AudioBookBloc>(context).add(CallApiAudioBook(
                idBook: state.bookDetail!.id.toString(),
                handleUnlock: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocBuilder<BookBloc, BookState>(
                        builder: (context, state) {
                          return ShowDialog(
                            textAndPrice:
                                'MUA SÁCH NÓI ${state.bookDetail!.audioBook!.price}',
                          );
                        },
                      );
                    },
                  );
                },
              ));
            },
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(ChooseColor.colorAuthor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side:
                            const BorderSide(color: ChooseColor.colorAuthor)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(SVGFile.ic_listenBook),
                const SizedBox(
                  width: 8,
                ),
                const Text("Nghe sách",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ButtonStar extends StatelessWidget {
  int? totalStar;
  int? star;
  Color colorBorder;
  Color colorBackground;
  ButtonStar(
      {super.key,
      required this.star,
      required this.totalStar,
      required this.colorBorder,
      required this.colorBackground});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 86,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: colorBorder),
          color: colorBackground),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$star",
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: ChooseColor.colorBlack),
          ),
          const SizedBox(
            width: 2,
          ),
          SvgPicture.asset(
            SVGFile.ic_star_tab_bar,
            width: 16,
            height: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "($totalStar)",
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: ChooseColor.colorTextNearStar),
          ),
        ],
      ),
    );
  }
}
