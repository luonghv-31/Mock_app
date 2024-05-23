import 'package:flutter/material.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/text_style_app.dart';

class ShowDialog extends StatelessWidget {
  String textAndPrice;
  ShowDialog({super.key, required this.textAndPrice});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
          height: 256,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'THÔNG BÁO',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ChooseColor.colorBlack),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                color: ChooseColor.colorButton,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24, top: 16, bottom: 16),
                child: Text(
                  'Để mở khóa nội dung này bạn phải tiến hành mua sách',
                  textAlign: TextAlign.center,
                  style: TextStyleAPP.textStyle14.copyWith(
                      color: ChooseColor.colorBlack,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Divider(
                color: ChooseColor.colorButton,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32, top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                     
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: ChooseColor.colorButton,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 32.0, right: 32, top: 16, bottom: 16),
                            child: Text(
                              'Huỷ bỏ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InkWell(
                        
                        onTap: () {},
                        child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: ChooseColor.colorDotChoose,
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 32.0, right: 32, top: 8, bottom: 8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '$textAndPrice ₭',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
          ),
    );
  }
}
