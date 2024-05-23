import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktest/constants/config.dart';
import 'package:mocktest/models/book_models/book_all_rating.dart';
import 'package:mocktest/models/book_detail_model/book_detail_model.dart';

import 'package:mocktest/models/book_models/more_book_model.dart';
import 'package:mocktest/models/book_models/book_total_review.dart';
import 'package:mocktest/services/book_detail/api_all_rating.dart';
import 'package:mocktest/services/book_detail/api_book_detail_provider.dart';

import 'package:mocktest/services/book_detail/api_more_book.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  TypeBook _typeBook = TypeBook.ebook;

  BookDetail? bookDetail;
  List<BookRelateModel>? _bookRelateModel;
  List<BookAllRating>? _bookAllRating;
  BookTotalReview? _bookTotalReview;
  String? _priceTypeBook;
  // EbookModel? _ebookModel;

  BookBloc() : super(const BookState()) {
    on<CallAPI>(_onCallAPI);
    on<SelectTypeBook>(_selectTypeBook);
    on<SelectTab>(_selectTab);
  }

  Future<void> _onCallAPI(CallAPI event, Emitter<BookState> emit) async {
    try {
      emit(state.copyWith(status: BookStatus.initial));

      bookDetail =
          await ApiBookDetailProvider().getBookDetail(idBook: event.idBook);
      _bookAllRating = await ApiAllRatingProvider()
          .getAllRating(bookDetail!.code.toString());
      _bookTotalReview = await ApiAllRatingProvider()
          .getTotalRating(bookDetail!.code.toString());
      _bookRelateModel =
          await ApiMoreBookProvider().getMoreBook(bookDetail!.sellerIsdn!);

      List<String> _sortTypeBook = bookDetail!.bookTypes!.split(',').toList();
      _sortTypeBook.sort();

      _sortTypeBook.first == '0'
          ? (
              _typeBook = TypeBook.book,
              _priceTypeBook = bookDetail?.hardBook?.price.toString()
            )
          : _sortTypeBook.first == '1'
              ? (
                  _typeBook = TypeBook.ebook,
                  _priceTypeBook = bookDetail!.ebook!.price.toString()
                )
              : (
                  _typeBook = TypeBook.audiobook,
                  _priceTypeBook = bookDetail!.audioBook!.price.toString()
                );

      return emit(state.copyWith(
        status: BookStatus.success,
        selectBook: _typeBook,
        bookDetail: bookDetail,
        bookAllRating: _bookAllRating,
        bookRelateModel: _bookRelateModel,
        bookTotalReview: _bookTotalReview,
        priceTypeBook: _priceTypeBook,
      ));
    } catch (e) {
      print('Api book in bloc $e');
      emit(state.copyWith(status: BookStatus.failure));
    }
  }

  _selectTypeBook(SelectTypeBook event, Emitter<BookState> emit) {
    try {
      if (state.status == BookStatus.success) {
        _typeBook = event.typeBook;
        _typeBook == TypeBook.book
            ? _priceTypeBook = bookDetail!.hardBook!.price.toString()
            : _typeBook == TypeBook.ebook
                ? _priceTypeBook = bookDetail!.ebook!.price.toString()
                : _priceTypeBook = bookDetail!.audioBook!.price.toString();
        return emit(state.copyWith(
          status: BookStatus.success,
          selectBook: _typeBook,
          bookDetail: bookDetail,
          bookTotalReview: _bookTotalReview,
          priceTypeBook: _priceTypeBook,
        ));
      }
    } catch (e) {
      print('err selectTypeBook $e');
    }
  }

  _selectTab(SelectTab event, Emitter<BookState> emit) {}
}
