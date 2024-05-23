part of 'audio_book_bloc.dart';

sealed class AudioBookEvent extends Equatable {
  const AudioBookEvent();

  @override
  List<Object> get props => [];
}

final class CallApiAudioBook extends AudioBookEvent {
  final String idBook;
  final VoidCallback handleUnlock;

  const CallApiAudioBook({required this.handleUnlock, required this.idBook});
}

final class PlayAudio extends AudioBookEvent {}

final class PauseAudio extends AudioBookEvent {}

final class BackWard10s extends AudioBookEvent {}

final class ForWard10s extends AudioBookEvent {}

final class Seek extends AudioBookEvent {
 final Duration seek;
 const Seek({required this.seek});
}

final class Next extends AudioBookEvent {}

final class Pre extends AudioBookEvent {}

final class UpdateBufferedAndDuration extends AudioBookEvent {}

final class UpdatePosition extends AudioBookEvent {}

final class LoopModee extends AudioBookEvent {}

final class ProcessState extends AudioBookEvent {}

final class SetSpeed extends AudioBookEvent {
final  double speed;
const  SetSpeed({required this.speed});
}

final class StopAudio extends AudioBookEvent {}
final class CurrentAudioIndex extends AudioBookEvent{}
final class SelectAudio extends AudioBookEvent{
  final int id;
 const SelectAudio({required this.id});
}

final class PopUpPurchase extends AudioBookEvent{
  final VoidCallback handleUnlock;
 const PopUpPurchase({required this.handleUnlock});

}

final class IsScreenPlay extends AudioBookEvent{
  
}