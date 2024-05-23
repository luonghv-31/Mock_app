import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/main.dart';
import 'package:mocktest/screens/book_detail/widget/app_bar_book_detail.dart';
import 'package:mocktest/screens/book_detail/widget/book_info.dart';
import 'package:mocktest/screens/book_detail/widget/bottom_bar.dart';
import 'package:mocktest/screens/book_detail/widget/more_book.dart';
import 'package:mocktest/screens/book_detail/widget/scroll_image_book_detail.dart';
import 'package:mocktest/screens/book_detail/widget/tab_bar.dart';

class BookDetailScreen extends StatefulWidget {
  final String idBook;
  const BookDetailScreen({super.key, required this.idBook});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<BookBloc>(context).add(CallAPI(idBook: widget.idBook));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state.status == BookStatus.success) {
              return Column(
                children: [
                  const AppBarBookDetail(),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 20),
                          child: ScrollImageBookDetail(),
                        ),
                        BookInfo(),
                        TabBarBook(),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 20, top: 20),
                          child: Divider(
                            height: 0,
                            color: ChooseColor.colorButton,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: MoreBook(),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    child: BottomBar(),
                  ),
                ],
              );
            } else if (state.status == BookStatus.initial) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: ChooseColor.colorButtonIsChoose,
                ),
              );
            } else {
              // print(state.status);
              return Align(
                alignment: Alignment.center,
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                 
                children: [
                 const Text('Lỗi tải dữ liệu'),
                 const SizedBox(  height: 10,),
                  InkWell(onTap :() =>  BlocProvider.of<BookBloc>(context).add(CallAPI(idBook: widget.idBook)),
                  
                  child: Container(
                    width: 80, height: 40,
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 173, 96), borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Text("Tải lại"))),)
                ],
              ));
            }
          },
        ),
      ),

      // bottomNavigationBar:
    );
  }
}
