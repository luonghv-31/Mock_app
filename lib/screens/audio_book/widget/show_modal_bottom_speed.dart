import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktest/bloc/audio_book_bloc/bloc/audio_book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/text_style_app.dart';

class ShowModalBottomSpeed extends StatelessWidget {
  const ShowModalBottomSpeed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AudioBookBloc>(),
      
      child: BlocBuilder<AudioBookBloc, AudioBookState>(
        // bloc: BlocProvider.of<AudioBookBloc>(context),
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white),
            height: 216,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tốc độ phát',
                          style: TextStyleAPP.textStyle16,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                  buttonSpeed(context,
                      speedd: 0.5, speed: '0.5x', isButtonChoose: state.speed == 0.5 ? true : false),
                  buttonSpeed(context,
                      speedd: 1, speed: '1x', isButtonChoose: state.speed == 1 ? true : false),
                  buttonSpeed(context,
                      speedd: 1.5, speed: '1.5x', isButtonChoose: state.speed == 1.5 ? true : false),
                  buttonSpeed(context,
                      speedd: 2, speed: '2x', isButtonChoose: state.speed == 2 ? true : false),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buttonSpeed(BuildContext context,
      {required double speedd,
      required String speed,
      required bool isButtonChoose}) {
    return InkWell(
      onTap: (){ context.read<AudioBookBloc>().add(SetSpeed(speed: speedd));
      Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        height: 36,
        decoration: BoxDecoration(
            color: isButtonChoose
                ? ChooseColor.colorBackgroundSelect
                : Colors.white,
            borderRadius: BorderRadius.circular(4)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              speed,
              style: TextStyleAPP.textStyle14
                  .copyWith(color: ChooseColor.colorBlack),
            ),
          ),
        ),
      ),
    );
  }
}
