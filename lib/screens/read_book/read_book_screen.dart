import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktest/bloc/read_book_bloc/bloc/read_book_bloc.dart';
import 'package:mocktest/common/decrypt_aes.dart';
import 'package:mocktest/constants/color_all_app.dart';
import 'package:mocktest/constants/svg_file.dart';
import 'package:mocktest/constants/url.dart';
import 'package:mocktest/screens/read_book/app_bar_read_book.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ReadBookScreen extends StatefulWidget {
  const ReadBookScreen({super.key});

  @override
  State<ReadBookScreen> createState() => _ReadBookScreenState();
}

late PdfViewerController _pdfViewController;

class _ReadBookScreenState extends State<ReadBookScreen> {
  @override
  void initState() {
    _pdfViewController = PdfViewerController();

    super.initState();
  }

  @override
  List<String> aa = [
    'https://www.clickdimensions.com/links/TestPDFfile.pdf',
    'https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf',
    'https://www.orimi.com/pdf-test.pdf'
  ];

  bool isShow = true;

  Widget build(BuildContext context) {
    Color calculateBackgroundColor(bool isShow, double progress) {
      // Màu nền ban đầu
      Color startColor = isShow ? Colors.black12 : Colors.white;
      // Màu nền kết thúc
      Color endColor = isShow ? Colors.white : Colors.black12;

      // Tính toán màu nền dựa trên tiến độ (progress) từ 0.0 đến 1.0
      return Color.lerp(startColor, endColor, progress) ?? startColor;
    }

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ReadBookBloc, ReadBookState>(
          builder: (context, state) {
            if (state.status == ReadBookStatus.success) {
              return Column(
                children: [
                  Container(
                    height: 48,
                    color: calculateBackgroundColor(isShow, 1.0),
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 1000),
                        opacity: isShow ? 1.0 : 0.0,
                        child: AppBarReadBook()),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height - 127,
                      child: SfPdfViewerTheme(
                        data: const SfPdfViewerThemeData(
                            backgroundColor: Colors.black12,
                            progressBarColor: ChooseColor.colorButtonIsChoose),
                        child: Stack(
                          children: [
                            SfPdfViewer.network(
                              URL.urlIMG +
                                  decryptAES(state
                                      .eBookModel!
                                      .bookContentDTO![state.currentChapter]
                                      .filePath),
                              controller: _pdfViewController,
                              scrollDirection: PdfScrollDirection.horizontal,
                              pageLayoutMode: PdfPageLayoutMode.single,
                              canShowScrollHead: false,
                              onTap: (PdfGestureDetails details) {
                                setState(() {
                                  isShow = !isShow;
                                  print(isShow);
                                });
                              },
                              onDocumentLoaded: (details) {
                                setState(() {});
                              },
                              onPageChanged: (details) {
                                setState(() {});
                              },
                              onDocumentLoadFailed: (details) {
                                print("Lỗi khi tải sách");
                              },
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 800),
                                    opacity: isShow ? 1.0 : 0.0,
                                    child: _pdfViewController.pageNumber != 1
                                        ? InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              _pdfViewController.previousPage();
                                            },
                                            child: Container(
                                                height: isShow
                                                    ? null
                                                    : double.infinity,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        offset:
                                                            const Offset(0, -1),
                                                        blurRadius: 50,
                                                        spreadRadius: 0,
                                                      ),
                                                    ]),
                                                child: SvgPicture.asset(
                                                  SVGFile.ic_arrow_left_pdf,
                                                )),
                                          )
                                        : const SizedBox(),
                                  ),
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 800),
                                    opacity: isShow ? 1.0 : 0.0,
                                    child: _pdfViewController.pageNumber !=
                                                _pdfViewController.pageCount ||
                                            _pdfViewController.pageNumber == 0
                                        ? InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              print(_pdfViewController
                                                  .pageNumber);
                                              _pdfViewController.nextPage();
                                            },
                                            child: Container(
                                                height: isShow
                                                    ? null
                                                    : double.infinity,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        offset:
                                                            const Offset(0, -1),
                                                        blurRadius: 50,
                                                        spreadRadius: 0,
                                                      ),
                                                    ]),
                                                child: SvgPicture.asset(
                                                  SVGFile.ic_arrow_right_pdf,
                                                )),
                                          )
                                        : const SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 800),
                              opacity: isShow ? 1.0 : 0.0,
                              child: _pdfViewController.pageNumber != 1
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 28.0),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            _pdfViewController.firstPage();
                                          },
                                          child: Container(
                                            width: 142,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ChooseColor.colorBorder,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                SvgPicture.asset(
                                                    SVGFile.ic_arrow_left_1),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text(
                                                  'Quay về trang 1',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: ChooseColor
                                                          .colorAuthor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            )
                          ],
                        ),
                      )),
                ],
              );
            } else if (state.status == ReadBookStatus.initial) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('Không tải được dữ liệu'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
