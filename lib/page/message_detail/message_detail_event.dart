import 'package:equatable/equatable.dart';
import 'package:vn_dental/models/network/response/message.dart';

abstract class MessageDetailEvent extends Equatable {
  MessageDetailEvent([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadMessage extends MessageDetailEvent {
  final bool isRefresh;
  final bool isLoadMore;
  final String chatId;

  LoadMessage({
    this.isRefresh = false,
    this.isLoadMore = false,
    this.chatId,
  });

  @override
  String toString() {
    return 'LoadMessage{isRefresh: $isRefresh, isLoadMore: $isLoadMore, chatId: $chatId}';
  }
}

class SentMessage extends MessageDetailEvent {
  final Message message;
  final String chatId;

  SentMessage(this.chatId, this.message);

  @override
  String toString() {
    return 'SentMessage{message: $message}';
  }
}

class ImagePick extends MessageDetailEvent {
  final bool isCamera;
  final Message message;
  final String chatID;

  ImagePick(this.isCamera, this.message, this.chatID);

  @override
  String toString() {
    return 'ImagePick{isCamera: $isCamera}';
  }
}

class OnTypingEvent extends MessageDetailEvent {
  final String text;

  OnTypingEvent(this.text);

  @override
  String toString() {
    return 'OnTypingEvent{text: $text}';
  }
}

class DeleteMessage extends MessageDetailEvent {
  final String chatId;
  final String messageID;

  DeleteMessage(this.chatId, this.messageID);

  @override
  String toString() {
    return 'DeleteMessage{chatId: $chatId, messageID: $messageID}';
  }
}

class AudioRecorder extends MessageDetailEvent {
  @override
  String toString() {
    return 'AudioRecorder{}';
  }
}

class IsCompress extends MessageDetailEvent {
  @override
  String toString() {
    return 'IsCompress{}';
  }
}
