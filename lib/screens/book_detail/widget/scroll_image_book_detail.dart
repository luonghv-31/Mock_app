import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/url.dart';
import 'package:mocktest/models/book_detail_model/book_detail_model.dart';

class ScrollImageBookDetail extends StatefulWidget {
  const ScrollImageBookDetail({super.key});

  @override
  State<ScrollImageBookDetail> createState() => _ScrollImageBookDetailState();
}

class _ScrollImageBookDetailState extends State<ScrollImageBookDetail> {
  int _currentIndex = 0;

  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.circular(4),
      child: Column(
        children: [
          BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              BookDetail? bookDetail;
              List<String> image = [];
              if (state.status == BookStatus.success) {
                bookDetail = state.bookDetail;
                image = bookDetail!.avatar!.split(',').toList();
                //  print(URL.urlIMG + image[1]);
              }
              if (bookDetail == null) {
                return const CircularProgressIndicator();
              }
              return Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: image.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;                         
                        });
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(4),
                          child: Image.network(
                            URL.urlIMG + image[index],
                            errorBuilder: (context, error, stackTrace) =>  SvgPicture.asset(SVGFile.img_book_error,),
                           
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                      height: 60.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: image.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.5)),
                              onTap: () {
                                setState(() {
                                  _currentIndex = index;
                                  _controller.animateToPage(index,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.5),
                                  border: _currentIndex == index
                                      ? Border.all(
                                          color:
                                              ChooseColor.colorButtonIsChoose,
                                          width: 2)
                                      : Border.all(
                                          color: Colors.transparent, width: 2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    URL.urlIMG + image[index],
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
