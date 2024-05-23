part of 'book_bloc.dart';

enum BookStatus { initial, success, failure }

final class BookState extends Equatable {
  const BookState(
      {this.status = BookStatus.initial,
      this.selectBook = TypeBook.book,
      this.bookAllRating = const <BookAllRating>[],
      this.bookDetail,
      this.bookRelateModel = const <BookRelateModel>[],
      this.bookTotalReview,
      this.priceTypeBook,
     // this.eBookContentModel
      });

  final BookStatus status;
  final TypeBook selectBook;
  final BookDetail? bookDetail;
  final List<BookRelateModel> bookRelateModel;
 // final EbookModel? eBookContentModel;

  final List<BookAllRating> bookAllRating;
  final BookTotalReview? bookTotalReview;
  final String? priceTypeBook;

  BookState copyWith({
    BookStatus? status,
    TypeBook? selectBook,
    BookDetail? bookDetail,
    List<BookRelateModel>? bookRelateModel,
    List<BookAllRating>? bookAllRating,
    BookTotalReview? bookTotalReview,
    String? priceTypeBook,
  //  EbookModel? eBookContentModel
  }) {
    return BookState(
      status: status ?? this.status,
      selectBook: selectBook ?? this.selectBook,
      bookAllRating: bookAllRating ?? this.bookAllRating,
      bookDetail: bookDetail,
      bookRelateModel: bookRelateModel ?? this.bookRelateModel,
      bookTotalReview: bookTotalReview ?? this.bookTotalReview,
      priceTypeBook: priceTypeBook ?? this.priceTypeBook,
    //  eBookContentModel: eBookContentModel
    );
  }

  @override
  List<Object> get props => [
        status, selectBook, bookAllRating, bookDetail ??"", bookRelateModel, bookTotalReview ?? "", priceTypeBook ?? "",// eBookContentModel ?? ""
      ];
}
