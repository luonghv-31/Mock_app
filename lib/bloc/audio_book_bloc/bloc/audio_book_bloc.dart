import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktest/common/decrypt_aes.dart';
import 'package:mocktest/constants/url.dart';

import 'package:mocktest/models/book_models/audio_book_model.dart';
import 'package:mocktest/services/book_detail/api_audio_book.dart';

part 'audio_book_event.dart';
part 'audio_book_state.dart';

class AudioBookBloc extends Bloc<AudioBookEvent, AudioBookState> {
  AudioBookModel? _audioBookModel;
  bool? _isPlaying;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Duration _buffered = Duration.zero;
  String? _stateLoop;
  double? _speed;
  bool? _isHaveMiniPlay;
  ProcessingState? _processingState;
  late ConcatenatingAudioSource _playlist;
  int? _currentAudio;
  bool? _popUpPurchase;
  bool _isScreenPlay = false;

  AudioBookBloc() : super(const AudioBookState()) {
    on<CallApiAudioBook>(_callApiAudioBook);
    on<PlayAudio>(_playAudio);
    on<PauseAudio>(_pauseAudio);
    on<Pre>(_pre);
    on<Next>(_next);
    on<BackWard10s>(_backward10s);
    on<ForWard10s>(_forward10s);
    on<Seek>(_seekk);
    on<UpdateBufferedAndDuration>(_updateBufferedAndDuration);
    on<UpdatePosition>(_updatePosition);
    on<LoopModee>(_loopModee);
    on<ProcessState>(_processState);
    on<SetSpeed>(_setSpeed);
    on<StopAudio>(_stopAudio);
    on<CurrentAudioIndex>(_currentAudioIndex);
    on<SelectAudio>(_selectAudio);
    on<PopUpPurchase>(_popUpPu);
    on<IsScreenPlay>(_haveScreenPlay);

    _audioPlayer.bufferedPositionStream.listen((event) {
      try {
        _buffered = event;

        add(UpdateBufferedAndDuration());
      } catch (e) {
        print(e);
      }
    });

    _audioPlayer.positionStream.listen((event) {
      try {
        _position = event;
        if (event == _duration) {}

        add(UpdatePosition());
      } catch (e) {
        print('lỗi $e');
      }
    });

    _audioPlayer.processingStateStream.listen((event) {
      _processingState = _audioPlayer.processingState;

      if (_processingState == ProcessingState.completed) {
        _isPlaying = false;

        _audioPlayer.seek(Duration.zero);
        if (_audioPlayer.loopMode.toString() == 'LoopMode.off') {
          _audioPlayer.pause();
        }
      }
      add(ProcessState());
    });

    _audioPlayer.sequenceStateStream.listen(
      (event) {
        _currentAudio = event!.currentIndex;

        if (_audioBookModel!.bookContentDTO![event.currentIndex].type == 1 &&
            _position == _duration) {
          _audioPlayer.seekToPrevious();

          _isPlaying = false;
          _popUpPurchase = true;
          add(PopUpPurchase(handleUnlock: () {}));

          add(PauseAudio());
        }

        add(CurrentAudioIndex());
      },
    );
  }

  Future<void> _callApiAudioBook(
      CallApiAudioBook event, Emitter<AudioBookState> emit) async {
    print('callapi audio book');
    try {
      _audioBookModel = await ApiAudioBookDetailProvider()
          .getAudioBookDetail(idBook: event.idBook);

      if (_audioBookModel!.bookContentDTO!.first.type == 0) {
        _isPlaying = true;

        List<AudioSource> listAudio = [];

        for (int i = 0; i < _audioBookModel!.bookContentDTO!.length; i++) {
          listAudio.add(AudioSource.uri(Uri.parse(URL.urlIMG +
              decryptAES(_audioBookModel!.bookContentDTO![i].filePath))));
        }

        _playlist = ConcatenatingAudioSource(
          children: listAudio,
        );
        _duration = await _audioPlayer.setAudioSource(_playlist,
                initialIndex: 0, initialPosition: Duration.zero) ??
            Duration.zero;

        add(PlayAudio());

        _isHaveMiniPlay = true;

        emit(state.copyWith(
          status: AudioBookStatus.success,
          audioBookModel: _audioBookModel,
          duration: _duration,
          isHaveMiniPlay: _isHaveMiniPlay,
          isPlaying: _isPlaying,
        ));
      } else {
        _isPlaying = false;
        _isHaveMiniPlay = false;
        _audioPlayer.dispose();

        emit(state.copyWith(
          isHaveMiniPlay: _isHaveMiniPlay,
          isPlaying: _isPlaying,
          audioBookModel: _audioBookModel,
        ));

        print('emit done');
        event.handleUnlock();
      }
    } catch (e) {
      print('Lỗi$e');
      return emit(state.copyWith(status: AudioBookStatus.failure));
    }
  }

  void _playAudio(PlayAudio event, Emitter<AudioBookState> emit) async {
    _isPlaying = true;
    _audioPlayer.play();

    return emit(state.copyWith(isPlaying: _isPlaying));
  }

  void _pauseAudio(PauseAudio event, Emitter<AudioBookState> emit) async {
    _isPlaying = false;
    await _audioPlayer.pause();
    return emit(state.copyWith(isPlaying: _isPlaying));
  }

  void _pre(Pre event, Emitter<AudioBookState> emit) {
    _audioPlayer.seekToPrevious();
  }

  void _next(Next event, Emitter<AudioBookState> emit) {
    _audioPlayer.seekToNext();
  }

  void _backward10s(BackWard10s event, Emitter<AudioBookState> emit) {
    _audioPlayer.seek(_position - const Duration(seconds: 10));
  }

  void _forward10s(ForWard10s event, Emitter<AudioBookState> emit) {
    if (_position < _duration) {
      _audioPlayer.seek(_position + const Duration(seconds: 10));
    }
  }

  void _seekk(Seek event, Emitter<AudioBookState> emit) {
    _audioPlayer.seek(event.seek);
    if (event.seek == _duration) {
      add(PlayAudio());
    }
  }

  void _updateBufferedAndDuration(
      UpdateBufferedAndDuration event, Emitter<AudioBookState> emit) {
    return emit(state.copyWith(buffered: _buffered, duration: _duration));
  }

  void _updatePosition(UpdatePosition event, Emitter<AudioBookState> emit) {
    return emit(state.copyWith(
      position: _position,
    ));
  }

  void _loopModee(LoopModee event, Emitter<AudioBookState> emit) {
    switch (_audioPlayer.loopMode.toString()) {
      case 'LoopMode.off':
        {
          _audioPlayer.setLoopMode(LoopMode.one);
        }

      case 'LoopMode.one':
        {
          _audioPlayer.setLoopMode(LoopMode.all);
        }

      default:
        _audioPlayer.setLoopMode(LoopMode.off);
    }

    _stateLoop = (_audioPlayer.loopMode).toString();

    return emit(state.copyWith(stateLoop: _stateLoop));
  }

  void _processState(ProcessState event, Emitter<AudioBookState> emit) {
    return emit(state.copyWith(
      processingState: _processingState,
      isPlaying: _isPlaying,
    ));
  }

  void _setSpeed(SetSpeed event, Emitter<AudioBookState> emit) {
    _speed = event.speed;
    _audioPlayer.setSpeed(event.speed);
    return emit(state.copyWith(speed: _speed));
  }

  void _stopAudio(StopAudio event, Emitter<AudioBookState> emit) {
    _audioPlayer.stop();
    _isHaveMiniPlay = false;
    _isPlaying = false;
    emit(
        state.copyWith(isHaveMiniPlay: _isHaveMiniPlay, isPlaying: _isPlaying));
  }

  void _currentAudioIndex(
      CurrentAudioIndex event, Emitter<AudioBookState> emit) {
    emit(state.copyWith(currentAudio: _currentAudio));
  }

  void _selectAudio(SelectAudio event, Emitter<AudioBookState> emit) async {
    await _audioPlayer.seek(Duration.zero, index: event.id);
  }

  void _popUpPu(PopUpPurchase event, Emitter<AudioBookState> emit) {
    emit(state.copyWith(popUpPurchase: _popUpPurchase));
    _popUpPurchase = false;
    emit(state.copyWith(popUpPurchase: _popUpPurchase));
  }

  void _haveScreenPlay(IsScreenPlay event, Emitter<AudioBookState> emit) {
    _isScreenPlay ? _isScreenPlay = false : _isScreenPlay = true;

    emit(state.copyWith(isScreenPlay: _isScreenPlay));
  }
}
