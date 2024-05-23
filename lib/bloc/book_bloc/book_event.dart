part of 'book_bloc.dart';

@immutable
sealed class BookEvent extends Equatable {


  @override
   List<Object> get props => [];
}

class SelectTypeBook extends BookEvent {
  final TypeBook typeBook;
  SelectTypeBook(this.typeBook);
}

class CallAPI extends BookEvent {
 final String idBook;
  CallAPI({required this.idBook});
}

class CallAPIRelateBook extends BookEvent {}

class SelectTab extends BookEvent {
  final TabController controller;

  SelectTab(this.controller);
}
