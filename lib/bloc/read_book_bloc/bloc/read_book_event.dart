part of 'read_book_bloc.dart';

sealed class ReadBookEvent extends Equatable {
  const ReadBookEvent();

  @override
  List<Object> get props => [];
}

final class CallApiReadBook extends ReadBookEvent{
  final String idBook;
  final VoidCallback handleUnlock;
  final VoidCallback pushScreen;
  const CallApiReadBook({required this.idBook, required this.handleUnlock, required this.pushScreen});
}

final class SelectChapter extends ReadBookEvent{
  final int currentChapter;
 const SelectChapter({
    required this.currentChapter
  });

 
}

 final class FirstPage extends ReadBookEvent{
  final int currentPage;
 const FirstPage({required this.currentPage});
 }