part of 'message_bloc.dart';

enum MessageStatus { initial, addmessage, success, failure }

class MessageState extends Equatable {
  const MessageState({
    this.status = MessageStatus.initial,
    this.messages = const <ConversationMessage>[],
    this.hasReachedMax = false,
  });

  final MessageStatus status;
  final List<ConversationMessage> messages;
  final bool hasReachedMax;

  MessageState copyWith(
      {MessageStatus? status,
      List<ConversationMessage>? messages,
      bool? hasReachedMax}) {
    return MessageState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''MessageBlocState { status: $status, hasReachedMax: $hasReachedMax, messages: ${messages.length} }''';
  }

  @override
  List<Object> get props => [status, messages, hasReachedMax];
}
