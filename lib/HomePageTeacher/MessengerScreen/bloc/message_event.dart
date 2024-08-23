part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
  @override
  List<Object> get props => [];
}

class MessageFetched extends MessageEvent {
  final Conversation conversation;
  const MessageFetched({required this.conversation});
  @override
  List<Object> get props => [conversation];
}
