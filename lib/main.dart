import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktest/bloc/audio_book_bloc/bloc/audio_book_bloc.dart';
import 'package:mocktest/bloc/book_bloc/book_bloc.dart';
import 'package:mocktest/bloc/read_book_bloc/bloc/read_book_bloc.dart';
import 'package:mocktest/screens/book_detail/book_detail_screen.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

final GlobalKey<NavigatorState> popUpGlobalKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookBloc(),
        ),
        BlocProvider(
          create: (context) => AudioBookBloc(),
        ),
        BlocProvider(create: (context) => ReadBookBloc())
      ],
      child: MaterialApp(
        navigatorKey: popUpGlobalKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'inter',
          colorScheme: const ColorScheme.light(),
        ),
        home: BookDetailScreen(
          idBook: '96',  // 395
        ),
      ),
    );
  }
}
