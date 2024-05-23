part of 'read_book_bloc.dart';

enum ReadBookStatus { initial, success, failure }

final class ReadBookState extends Equatable {
  const ReadBookState(
      {this.status = ReadBookStatus.initial,
      this.eBookModel,
      this.isEbookPurchase = true,
      this.currentChapter = 0,
      this.firstPage = 1});

  final ReadBookStatus status;
  final EbookModel? eBookModel;
  final bool isEbookPurchase;
  final int currentChapter;
  final int firstPage;
  ReadBookState copyWith(
      {ReadBookStatus? status,
      EbookModel? eBookModel,
      bool? isEbookPurchase,
      int? currentChapter,
      int? firstPage}) {
    return ReadBookState(
        status: status ?? this.status,
        eBookModel: eBookModel ?? this.eBookModel,
        isEbookPurchase: isEbookPurchase ?? this.isEbookPurchase,
        currentChapter: currentChapter ?? this.currentChapter,
        firstPage: firstPage ?? this.firstPage);
  }

  @override
  List<Object> get props =>
      [status, eBookModel ?? "", isEbookPurchase, currentChapter, firstPage];
}
