import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bts_app/models/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../config/networkservice.dart';
import '../../../models/convesationMessage/conversation.dart';
import '../../../models/convesationMessage/conversationmessage.dart';
import '../../../models/data_response.dart';
part 'message_event.dart';
part 'message_state.dart';

const _messageLimit = 20;

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(const MessageState()) {
    on<MessageFetched>(_onFetchMessage);
  }
  // final Logger logger = Logger(level: Level.info);
  final NetworkService networkService = NetworkService();
  // final Conversation conversation;
  final ScrollController scrollController = ScrollController();

  // @override
  // Stream<MessageState> mapEventToState(MessageEvent event) async* {
  //   if (event is MessageFetched) {
  //     yield await _mapPostFetchedToState(state, event);
  //   }

  //   yield await _mapPostFetchedToState(state, event);
  //   scrollList();
  // }

  void _onFetchMessage(MessageFetched event, Emitter<MessageState> emit) async {
    // if (state.hasReachedMax) {
    //   return emit(state);
    // }
    emit(state.copyWith(status: MessageStatus.initial));
    try {
      // if (state.status == MessageStatus.initial) {
      //   final messages = await _fetchmessages(event.conversation);
      //   return emit(state.copyWith(
      //     status: MessageStatus.success,
      //     messages: messages,
      //     hasReachedMax: false,
      //   ));
      // }

      final newMessages =
          await _fetchmessages(event.conversation, state.messages.length);
      scrollList();
      return newMessages.isEmpty
          ? emit(state.copyWith(
              status: MessageStatus.initial, hasReachedMax: true))
          : emit(state.copyWith(
              status: MessageStatus.success,
              messages:
                  newMessages, // List.of(state.messages)..addAll(messages),
              hasReachedMax: false,
            ));
    } on Exception {
      state.copyWith(status: MessageStatus.failure);
    }
  }

  void scrollList() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) =>
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100), curve: Curves.ease));
    }
    // logger.i('scrollList');
  }

  // Future<MessageState> _mapPostFetchedToState(MessageState state, event) async {
  //   if (state.hasReachedMax) return state;
  //   // final newMessage;
  //   try {
  //     if (state.status == MessageStatus.initial) {
  //       final messages = await _fetchmessages(event.conversation);
  //       return state.copyWith(
  //         status: MessageStatus.success,
  //         messages: messages,
  //         hasReachedMax: false,
  //       );
  //     }

  //     final newMessages =
  //         await _fetchmessages(event.conversation, state.messages.length);
  //     return newMessages.isEmpty
  //         ? state.copyWith(hasReachedMax: true)
  //         : state.copyWith(
  //             status: MessageStatus.success,
  //             messages:
  //                 newMessages, // List.of(state.messages)..addAll(messages),
  //             hasReachedMax: false,
  //           );
  //   } on Exception {
  //     return state.copyWith(status: MessageStatus.failure);
  //   }
  // }

  Future<List<ConversationMessage>> _fetchmessages(Conversation conversation,
      [int startIndex = 0]) async {
    List<ConversationMessage> messages = [];
    try {
      final DataResponse dataResponse = await NetworkService()
          .getAllMessage(conversation.iD ?? "", Profile.parentID);

      if (dataResponse.data != null) {
        for (var info in dataResponse.data) {
          messages.add(ConversationMessage.fromJson(info));
        }
      }

      return messages;
      // return;
    } catch (ex) {
      throw Exception('error fetching messages');
    }
  }

  // Future<ConversationMessage> addMessage(
  //     ConversationMessage conversationMessage) async {
  //   final message = networkService.addMessage(conversationMessage);

  //   return message;
  // }
}
