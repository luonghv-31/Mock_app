import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mocktest/main.dart';
import 'package:mocktest/models/book_models/ebook_model.dart';
import 'package:mocktest/services/book_detail/api_ebook.dart';
import 'package:mocktest/widgets/show_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

part 'read_book_event.dart';
part 'read_book_state.dart';

class ReadBookBloc extends Bloc<ReadBookEvent, ReadBookState> {
  EbookModel? _ebookModel;
  // bool? _isEbookPurchase;
  int? _currentChapter;
  ReadBookBloc() : super(const ReadBookState()) {
    on<CallApiReadBook>(_callApiReadBook);
    on<SelectChapter>(_SelectChapter);
    on<FirstPage>(_firstPage);
  }

  void _callApiReadBook(
      CallApiReadBook event, Emitter<ReadBookState> emit) async {
    try {
      _ebookModel =
          await ApiEBookDetailProvider().getEBookDetail(idBook: event.idBook);

      if (_ebookModel!.bookContentDTO![0].type == 0) {
        // _isEbookPurchase = true;
        event.pushScreen();

        emit(state.copyWith(
            status: ReadBookStatus.success, eBookModel: _ebookModel));
      } else {
        // _isEbookPurchase = false;
        event.handleUnlock();
      }
    } catch (e) {
      print('Bloc readBook error $e');
      emit(state.copyWith(status: ReadBookStatus.failure));
    }
  }

  void _SelectChapter(SelectChapter event, Emitter<ReadBookState> emit) {
    _currentChapter = event.currentChapter;
    emit(state.copyWith(currentChapter: _currentChapter));
  }

  void _firstPage(FirstPage event, Emitter<ReadBookState> emit) {
    event.currentPage == 1
        ? emit(state.copyWith(firstPage: 1))
        : emit(state.copyWith(firstPage: event.currentPage));
  }
}
