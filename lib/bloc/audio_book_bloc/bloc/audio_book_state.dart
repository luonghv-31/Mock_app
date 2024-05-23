part of 'audio_book_bloc.dart';

enum AudioBookStatus { initial, success, failure }

final class AudioBookState extends Equatable {
  const AudioBookState(
      {this.status = AudioBookStatus.initial,
      this.audioBookModel,
      this.buffered = Duration.zero,
      this.duration = Duration.zero,
      this.position = Duration.zero,
      this.isPlaying = false,
      this.stateLoop = 'LoopMode.off',
      this.processingState = ProcessingState.idle,
      this.speed = 1,
      this.isHaveMiniPlay = false,
      this.currentAudio = 0,
      this.popUpPurchase = false,
      this.isScreenPlay =false
  });

  final AudioBookStatus status;
  final AudioBookModel? audioBookModel;
  final Duration duration;
  final Duration position;
  final Duration buffered;
  final bool isPlaying;
  final String stateLoop;
  final ProcessingState processingState;
  final double speed;
  final bool isHaveMiniPlay;
  final int currentAudio;
  final bool popUpPurchase;
  final bool isScreenPlay;
  AudioBookState copyWith(
      {AudioBookStatus? status,
      AudioBookModel? audioBookModel,
      Duration? duration,
      Duration? position,
      Duration? buffered,
      bool? isPlaying,
      String? stateLoop,
      ProcessingState? processingState,
      double? speed,
      bool? isHaveMiniPlay,
      int? currentAudio,
      bool? popUpPurchase,
      bool? isScreenPlay
    }) {
    return AudioBookState(
        status: status ?? this.status,
        audioBookModel: audioBookModel ?? this.audioBookModel,
        buffered: buffered ?? this.buffered,
        duration: duration ?? this.duration,
        position: position ?? this.position,
        isPlaying: isPlaying ?? this.isPlaying,
        stateLoop: stateLoop ?? this.stateLoop,
        processingState: processingState ?? this.processingState,
        speed: speed ?? this.speed,
        isHaveMiniPlay: isHaveMiniPlay ?? this.isHaveMiniPlay,
        currentAudio: currentAudio ?? this.currentAudio,
        popUpPurchase: popUpPurchase ?? this.popUpPurchase,
        isScreenPlay: isScreenPlay ?? this.isScreenPlay
      );
  }

  @override
  List<Object> get props => [
        status,
        audioBookModel ?? '',
        buffered,
        duration,
        position,
        isPlaying,
        stateLoop,
        processingState,
        speed,
        isHaveMiniPlay,
        currentAudio,
        popUpPurchase,
        isScreenPlay
      ];
}
